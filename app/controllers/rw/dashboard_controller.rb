module Rw
  class DashboardController < ApplicationController
    def index
      redirect_to users_home_path
    end
  end
end