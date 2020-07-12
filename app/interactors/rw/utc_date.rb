module Rw
  class UtcDate
    include Interactor

    def call
      time_zone =
          if Time.zone.parse(Time.now.to_s).dst?
            '+0430'
          else
            '+0330'
          end
      time = context.time ? context.time : '00:00:00'
      context.result = "#{Rw::JalaliToGregorian.call(date: context.date_time).result} #{time} #{time_zone}"
    end
  end
end
