module Rw::Payment::Pep
  class SubPaymentCreate
    include Interactor

    def call
      builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.SubPaymentList {
          xml.SubPayments {
            context.data.count.times do |i|
              xml.SubPayment {
                xml.SubPayID(context.data[i][:sub_pay_id])
                xml.Amount(context.data[i][:amount])
                xml.Date(context.data[i][:date])
                xml.Account(context.data[i][:account])
                xml.Description(context.data[i][:description])
              }
            end
          }
        }
      end
      context.xml = builder.to_xml
      context.result = Base64.encode64(context.xml)
    end
  end
end