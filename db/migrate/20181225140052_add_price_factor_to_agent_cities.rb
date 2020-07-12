class AddPriceFactorToAgentCities < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_agent_cities, :price_factor, :float
  end
end
