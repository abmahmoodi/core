module Rw::Payment::Pep
  class SignData
    include Interactor

    def call
      key=OpenSSL::PKey::RSA.new(File.read("#{Rails.root}/signature.pem"))
      signature = key.sign(OpenSSL::Digest::SHA1.new, context.data)
      context.result = Base64.encode64(signature).delete("\n")
    end
  end
end