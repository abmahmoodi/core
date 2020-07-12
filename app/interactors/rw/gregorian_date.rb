class GregorianDate
  include Interactor

  YEAR_POS = 0..1
  MONTH_POS = 2..3
  DAY_POS = 4..5

  HOUR_POS = 0..1
  MINUTE_POS = 2..3
  SECOND_POS = 4..5

  def call
    jalali_date = context.jalali_date
    time_part = context.time_part

    time_part = "#{time_part[HOUR_POS]}:#{time_part[MINUTE_POS]}:#{time_part[SECOND_POS]}".to_time

    date_part = JalaliGregorian.call(date: "13#{jalali_date[YEAR_POS]}/#{jalali_date[MONTH_POS]}/#{jalali_date[DAY_POS]}").result

    context.result = DateTime.new(date_part.year, date_part.month, date_part.day, time_part.hour, time_part.min, time_part.sec)
  end
end