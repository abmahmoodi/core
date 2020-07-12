module Rw
  class GeoLocation < ActiveRecord::Base
    has_one :geo_location, class_name: 'GeoLocation', foreign_key: :parent_id
    belongs_to :province, class_name: 'GeoLocation', foreign_key: :parent_id, optional: true

    class << self
      def province_cities
        Rw::GeoLocation.
            joins(:province).
            select("'' as row, rw_geo_locations.id city_id, provinces_rw_geo_locations.id province_id,
                    rw_geo_locations.title city,provinces_rw_geo_locations.*").
            where('rw_geo_locations.root=1 and rw_geo_locations.parent_id>1').load
      end

      def provinces
        Rw::GeoLocation.select('id, title').where(parent_id: 1, root: 1).load
      end
    end
  end
end
