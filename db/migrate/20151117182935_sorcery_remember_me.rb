class SorceryRememberMe < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_users, :remember_me_token, :string, :default => nil
    add_column :rw_users, :remember_me_token_expires_at, :datetime, :default => nil

    add_index :rw_users, :remember_me_token
  end
end