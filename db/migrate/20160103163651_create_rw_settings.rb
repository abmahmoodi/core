class CreateRwSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :rw_settings do |t|
      t.hstore :key_value

      t.timestamps null: false
    end
  end
end
