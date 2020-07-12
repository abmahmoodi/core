module Rw
  class JalaliDateTimeFormat
    include Interactor

    def call
      date_time = context.date_time.in_time_zone('Tehran')
      context.result = "#{Rw::GregorianToJalali.call(date_time: date_time).jalali_date.strftime('%Y/%m/%d')} - #{date_time.strftime('%H:%M')}"
    end
  end
end