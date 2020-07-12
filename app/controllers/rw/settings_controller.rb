require_dependency "rw/application_controller"

module Rw
  class SettingsController < ApplicationController
    def setting_form
      @settings = Rw::Setting.pluck(:key_value)[0]
    end
    
    def save_setting
      Rw::Setting.update_all(key_value: params[:settings])
      flash.now[:notice] = t(:'messages.successful_save')
    end
  end
end
