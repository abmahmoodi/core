class FetchGeoLocations
  include Interactor

  def call
    raise I18n.t(:'messages.permission_denied') unless GeoLocationPolicy.new(context.view.current_user, :geo_location).index?

    geo_locations = Rw::GeoLocation.province_cities
    if context.view.params[:sSearch].present?
      geo_locations = geo_locations.where('rw_geo_locations.title LIKE :search OR provinces_rw_geo_locations.title LIKE :search',
                                            search: "%#{context.view.params[:sSearch]}%")
    end

    geo_location_datatable = Rw::ServerSideDatatable.new(context.view, geo_locations, %w[title city city_id])
    geo_locations = geo_location_datatable.fetch_model

    hash_geo_locations =
        geo_locations.map do |geo_location|
          [
              geo_location.row,
              geo_location.title,
              geo_location.city,
              geo_location.city_id
          ]
        end
    context.result = geo_location_datatable.as_json(hash_geo_locations)
  end
end
