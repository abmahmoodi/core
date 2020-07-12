class CreateRwAgentCities < ActiveRecord::Migration[5.1]
  def change
    create_table :rw_agent_cities do |t|
      t.integer :user_id
      t.integer :geo_location_id

      t.timestamps
    end
  end
end
