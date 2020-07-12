module Rw::Payment::Pep
  class CheckTransactionResult
    include Interactor

    def call
      data = {"TransactionReferenceID" => context.tref}
      result = Api.call(api_method: 'Payment/CheckTransactionResult',
                        params: data.to_json).result

      Rails.logger.info('Getting info from CheckTransactionResult...')
      Rails.logger.info(result)

      if result['IsSuccess']
        context.trace_number = result['TraceNumber']
      else
        context.errors = result['Message']
        context.fail!
      end
    end
  end
end