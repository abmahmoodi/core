require_dependency "rw/application_controller"
require_dependency "#{Rails.root}/engines/core/app/interactors/rw/model_errors"

module Rw
  class GeoLocationsController < ApplicationController
    def destroy_geo
      if params[:id] == '0'
        @error = flash.now[:error] = t(:'messages.no_selection')
        return
      end
      begin
        ids = params[:id].split(',').to_a
        Rw::GeoLocation.where('id in (?)', ids).delete_all
        flash.now[:notice] = t(:'messages.successful_destroy')
      rescue Exception => e
        @error = flash.now[:error] = e.message
      end
    end

    def index
    end

    def geo_location_datatable
      respond_to do |format|
        format.html
        format.json { render json: FetchGeoLocations.call(view: view_context).result }
      end
    end

    def show
    end

    def new
      @geo_location = GeoLocationForm.new(GeoLocation.new)
    end

    def edit
      @geo_location = GeoLocationForm.new(GeoLocation.find_by_id(params[:id]))
    end

    def create
      result = GeoLocationCreate.call(geo_location_data: params[:geo_location],
                                      user: current_user)

      if result.success?
        flash.now[:notice] = t(:'messages.successful_save')
      else
        Rw::ModelErrors.call(model: result.geo_location, class_name: self)
      end
    rescue Exception => e
      @error = '1'
      flash.now[:error] = e.message
    end

    def update
      result = GeoLocationUpdate.call(geo_location_data: params[:geo_location],
                                      id: params[:id],
                                      user: current_user)
      if result.success?
        flash.now[:notice] = t(:'messages.successful_save')
      else
        Rw::ModelErrors.call(model: result.geo_location, class_name: self)
      end
    rescue Exception => e
      @error = '1'
      flash.now[:error] = e.message
    end

    def destroy
      result = GeoLocationDestroy.call(id: params[:id], user: current_user)
      if result.success?
        flash.now[:notice] = t(:'messages.successful_destroy')
      else
        flash.now[:error] = result.error
      end
    rescue Exception => e
      @error = '1'
      flash.now[:error] = e.message
    end
  end
end
