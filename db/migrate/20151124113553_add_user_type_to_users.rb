class AddUserTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_users, :user_type, :integer
  end
end
