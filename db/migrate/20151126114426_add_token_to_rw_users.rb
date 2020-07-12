class AddTokenToRwUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_users, :auth_token, :string
  end
end
