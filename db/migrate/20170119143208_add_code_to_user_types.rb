class AddCodeToUserTypes < ActiveRecord::Migration[5.1]
  def change
    add_column(:rw_user_types, :code, :integer)
  end
end
