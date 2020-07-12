module Rw
  class UserType < ActiveRecord::Base
    validates :title, presence: true
    validates :title, uniqueness: true
  end
end
