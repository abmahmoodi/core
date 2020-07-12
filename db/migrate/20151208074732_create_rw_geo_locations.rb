class CreateRwGeoLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :rw_geo_locations do |t|
      t.string :title
      t.integer :parent_id
      t.integer :root

      t.timestamps null: false
    end
  end
end
