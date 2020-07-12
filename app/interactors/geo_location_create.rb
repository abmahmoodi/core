class GeoLocationCreate
  include Interactor

  def call
    Rw::Authorize.call(context.user, GeoLocationPolicy, :create?)

    geo_location = GeoLocationForm.new(Rw::GeoLocation.new)
    if geo_location.validate(context.geo_location_data)
      geo_location.save
    else
      context.geo_location = geo_location
      context.fail!
    end
  end
end
