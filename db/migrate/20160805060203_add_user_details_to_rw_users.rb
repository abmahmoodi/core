class AddUserDetailsToRwUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :rw_users, :last_login, :datetime
  	add_column :rw_users, :login_count, :int
  end
end

