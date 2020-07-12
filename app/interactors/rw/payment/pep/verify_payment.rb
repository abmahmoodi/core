module Rw::Payment::Pep
  class VerifyPayment
    include Interactor

    def call
      data = {"InvoiceNumber" => context.invoice_number,
              "InvoiceDate" => context.invoice_date,
              "TerminalCode" => context.terminal_code,
              "MerchantCode" => context.merchant_code,
              "Amount" => context.amount,
              "Timestamp" => Time.now.strftime('%Y/%m/%d %H:%M:%S')
      }
      signed_data = SignData.call(data: data.to_json).result
      result = Api.call(api_method: 'Payment/VerifyPayment',
                        params: data.to_json,
                        signed_data: signed_data).result

      if result['IsSuccess']
        context.ref_number = result['ShaparakRefNumber']
      else
        context.errors = result['Message']
        context.fail!
      end
    end
  end
end