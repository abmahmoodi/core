module Rw
  class JalaliMonthYear
    include Interactor

    def call
      jalali_date = context.date_time.to_parsi
      context.month = jalali_date.month
      context.year = jalali_date.year
    end
  end
end