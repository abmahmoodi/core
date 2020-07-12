module Rw
  class DatabaseFormatDate
    include Interactor

    def call
      data = context.data.tr('۰۱۲۳۴۵۶۷۸۹', '0123456789')
      context.result = data.nil? || data == '' ? nil : "#{Rw::JalaliToGregorian.call(date: data).result} 00:00:00 #{Time.zone.to_s}"
    end
  end
end