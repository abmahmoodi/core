module Rw::Payment::Pep
  class GetToken
    include Interactor

    def call
      data = {"InvoiceNumber" => context.invoice_number,
              "InvoiceDate" => context.invoice_date,
              "TerminalCode" => context.terminal_code,
              "MerchantCode" => context.merchant_code,
              "Amount" => context.amount,
              "RedirectAddress" => context.redirect_address,
              "Timestamp" => Time.now.strftime('%Y/%m/%d %H:%M:%S'),
              "Action" => 1003,
              "Mobile" => context.mobile,
              "Email" => context.email,
              "MultiPaymentData" => context.multi_payment_encoded64
      }
      signed_data = SignData.call(data: data.to_json).result
      result = Api.call(api_method: 'Payment/GetToken',
                        params: data.to_json,
                        signed_data: signed_data).result

      if result['IsSuccess']
        context.token = result['Token']
      else
        context.errors = result['Message']
        context.fail!
      end
    end
  end
end