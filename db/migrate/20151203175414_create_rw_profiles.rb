class CreateRwProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :rw_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :national_code

      t.timestamps null: false
    end
  end
end
