class SorceryActivityLogging < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_users, :last_login_at,     :datetime, :default => nil
    add_column :rw_users, :last_logout_at,    :datetime, :default => nil
    add_column :rw_users, :last_activity_at,  :datetime, :default => nil
    add_column :rw_users, :last_login_from_ip_address, :string, :default => nil

    add_index :rw_users, [:last_logout_at, :last_activity_at]
  end
end