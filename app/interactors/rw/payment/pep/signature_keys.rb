require 'rexml/document'

module Rw::Payment::PEP
  class SignatureKeys
    include Interactor
    include REXML

    def call
      xml_file = File.new("#{Rails.root}/private_key.xml")
      xml_doc = Document.new(xml_file)
      public_key = XPath.first(xml_doc, '//RSAKeyValue/Exponent').text
      private_key = XPath.first(xml_doc, '//RSAKeyValue/D').text
      modulus = XPath.first(xml_doc, '//RSAKeyValue/Modulus').text

      context.modulus = BinaryToNumber.call(data: Base64.decode64(modulus)).result
      context.private_key = BinaryToNumber.call(data: Base64.decode64(private_key)).result
      context.public_key = BinaryToNumber.call(data: Base64.decode64(public_key)).result
      context.key_length = Base64.decode64(modulus).length * 8
    end
  end
end