module Rw::Payment::Pep
  class Api
    include Interactor

    BASE_URI = 'https://pep.shaparak.ir/Api/v1'

    def call
      context.result = HTTParty.post("#{BASE_URI}/#{context.api_method}",
                                     :headers => {'Content-Type': 'application/json',
                                                   'Sign' => context.signed_data},
                                     :body => context.params)
    end
  end
end