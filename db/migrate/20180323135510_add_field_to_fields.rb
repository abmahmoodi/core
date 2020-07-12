class AddFieldToFields < ActiveRecord::Migration[5.1]
  def change
    add_column(:rw_fields, :persian_name, :string)
  end
end
