module Rw
  class GregorianToJalali
    include Interactor

    def call
      context.jalali_date = context.date_time&.to_parsi
    end
  end
end
