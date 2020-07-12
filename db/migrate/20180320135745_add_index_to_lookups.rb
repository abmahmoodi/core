class AddIndexToLookups < ActiveRecord::Migration[5.1]
  def change
    add_index(:rw_lookups, [:category, :code], unique: true)
  end
end
