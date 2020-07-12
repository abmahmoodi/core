module Rw
  class Setting < ActiveRecord::Base
    store_accessor :key_value
  end
end
