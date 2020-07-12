class AddCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_users, :code, :integer, index: true
  end
end
