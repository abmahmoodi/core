module Rw::Payment::Pep
  class GetSubPaymentsReport
    include Interactor

    def call
      data = {"TerminalCode" => context.terminal_code,
              "MerchantCode" => context.merchant_code,
              "Timestamp" => Time.now.strftime('%Y/%m/%d %H:%M:%S'),
              "StartDate" => context.start_date,
              "EndDate" => context.end_date
      }
      signed_data = SignData.call(data: data.to_json).result
      result = Api.call(api_method: 'Payment/GetSubPaymentsReport',
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