class GeoLocationUpdate
  include Interactor

  def call
    Rw::Authorize.call(context.user, GeoLocationPolicy, :update?)

    geo_location = Rw::GeoLocation.find(context.id)
    geo_location_form = GeoLocationForm.new(geo_location)
    if geo_location_form.validate(context.geo_location_data)
      geo_location_form.save
      # geo_location.update_attributes(title: context.geo_location_data[:title],
      #                                parent_id: context.geo_location_data[:parent_id])
    else
      context.geo_location = geo_location_form
      context.fail!
    end
  end
end
