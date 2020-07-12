require_dependency "rw/application_controller"
require_dependency "#{Rails.root}/engines/core/app/interactors/rw/model_errors"
require_dependency "#{Rails.root}/engines/core/app/interactors/rw/payment/pep/get_token"

module Rw
  class PaymentsController < ApplicationController
    def pep_gateway
      mobile = params[:mobile]
      email = params[:email]
      amount = params[:amount]
      multi_payment_encoded64 = params[:multi_payment_encoded64]
      checkout_account = params[:checkout_account]
      invoice_number = Rw::Panel::UserPayments::GenerateInvoiceNumber.call.result
      user_payment = Rw::Panel::UserPayments::UserPaymentCreate.call(
          user: current_user,
          user_payment_data: {user_id: current_user.id,
                              price: params[:amount],
                              invoice_number: invoice_number,
                              status: 1,
                              back_url: params[:back_url],
                              payment_type: params[:payment_type]}).user_payment

      invoice_date = user_payment.model.created_at
      render locals: {mobile: mobile, email: email, amount: amount,
                      invoice_number: invoice_number,
                      invoice_date: invoice_date.strftime('%Y/%m/%d'),
                      multi_payment_encoded64: multi_payment_encoded64,
                      checkout_account: checkout_account}
    end

    def to_pep_gateway
      config = YAML.load_file("#{Rails.root}/engines/panel/config/payment.yml")
      result = Rw::Payment::Pep::GetToken.call(invoice_number: params[:gateway][:invoice_number],
                                               invoice_date: params[:gateway][:invoice_date],
                                               merchant_code: config['gateway']['merchant'],
                                               terminal_code: config['gateway']['terminal'],
                                               amount: params[:gateway][:amount].to_i,
                                               redirect_address: 'http://energymeter.ir/pep_gateway_back',
                                               mobile: params[:gateway][:mobile],
                                               email: params[:gateway][:email],
                                               multi_payment_encoded64: params[:gateway][:multi_payment_encoded64])
      logger.info(result)
      if result.success?
        token = result.token
        redirect_to "https://pep.shaparak.ir/payment.aspx?n=#{token}"
      end
    end

    def pep_gateway_back
      user_payment = Rw::Panel::UserPayment.find_by(invoice_number: params[:iN])
      result = Rw::Payment::Pep::CheckTransactionResult.call(tref: params[:tref])

      if result.success?
        Rw::Panel::UserPayments::UserPaymentUpdate.call(id: user_payment.id, user: current_user,
                                                        user_payment_data: {track_code: result.trace_number})

        track_code = result.trace_number
        config = YAML.load_file("#{Rails.root}/engines/panel/config/payment.yml")
        result = Rw::Payment::Pep::VerifyPayment.call(merchant_code: config['gateway']['merchant'],
                                                      terminal_code: config['gateway']['terminal'],
                                                      invoice_number: user_payment.invoice_number,
                                                      invoice_date: user_payment.created_at.strftime('%Y/%m/%d'),
                                                      amount: user_payment.price)
        if result.success?
          Rw::Panel::UserPayments::UserPaymentUpdate.call(id: user_payment.id, user: current_user,
                                                          user_payment_data: {status: 2})
          message = t(:'payments.messages.success_transaction')
          success = true
        else
          message = t(:'payments.messages.fail_transaction')
          error = result.errors
          success = false
        end
      else
        message = t(:'payments.messages.fail_transaction')
        error = result.errors
        success = false
      end
      render locals: {invoice_number: user_payment.invoice_number,
                      invoice_date: Rw::GregorianToJalali.call(date_time: user_payment.created_at.in_time_zone('Tehran')).jalali_date.strftime('%Y/%m/%d'),
                      amount: user_payment.price.round(0),
                      message: message,
                      error: error,
                      track_code: track_code, success: success,
                      slug: user_payment.slug, back_url: user_payment.back_url}
    end
  end
end