class AddSlugToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column(:rw_users, :slug, :string)
  end
end
