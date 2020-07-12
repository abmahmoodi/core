class AddPersianTitleToUserTypes < ActiveRecord::Migration[5.1]
  def change
    add_column(:rw_user_types, :persian_title, :string)
  end
end
