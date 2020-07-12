module Rw
  class AllCities
    include Interactor

    def call
      context.cities = Rw::GeoLocation.select(:id, :title).where('parent_id > 1 and root = 1').load
    end
  end
end