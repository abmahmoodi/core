module Rw
  class ApplicationController < ActionController::Base
    before_action :require_login
    # rescue_from ActiveRecord::InvalidForeignKey, with: :render_error

    def render_error
      # flash.now[:error] = 'به علت وابستگی این ردیف امکان حذف وجود ندارد'
      # render :js => "alert('به علت وابستگی این ردیف امکان حذف وجود ندارد')"
    end

    def not_authenticated
      flash[:error] = t(:'messages.not_authenticated')
      redirect_to log_in_path
    end
  end
end
