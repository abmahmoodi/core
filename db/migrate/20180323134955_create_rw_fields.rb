class CreateRwFields < ActiveRecord::Migration[5.1]
  def change
    create_table :rw_fields do |t|
      t.string :table_name
      t.string :field_name
      t.string :field_type

      t.timestamps
    end
  end
end
