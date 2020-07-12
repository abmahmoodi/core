class SorceryResetPassword < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_users, :reset_password_token, :string, :default => nil
    add_column :rw_users, :reset_password_token_expires_at, :datetime, :default => nil
    add_column :rw_users, :reset_password_email_sent_at, :datetime, :default => nil

    add_index :rw_users, :reset_password_token
  end
end