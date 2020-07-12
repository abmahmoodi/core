class SorceryUserActivation < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_users, :activation_state, :string, :default => nil
    add_column :rw_users, :activation_token, :string, :default => nil
    add_column :rw_users, :activation_token_expires_at, :datetime, :default => nil

    add_index :rw_users, :activation_token
  end
end