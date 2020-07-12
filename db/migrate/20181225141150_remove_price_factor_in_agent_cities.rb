class RemovePriceFactorInAgentCities < ActiveRecord::Migration[5.1]
  def change
    remove_column :rw_agent_cities, :price_factor
    add_column :rw_geo_locations, :price_factor, :float
  end
end
