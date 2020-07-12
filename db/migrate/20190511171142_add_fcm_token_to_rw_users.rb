class AddFcmTokenToRwUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_users, :fcm_token, :string
  end
end
