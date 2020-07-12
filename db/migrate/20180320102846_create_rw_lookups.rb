class CreateRwLookups < ActiveRecord::Migration[5.1]
  def change
    create_table :rw_lookups do |t|
      t.string :category
      t.integer :code
      t.string :title

      t.timestamps
    end
  end
end
