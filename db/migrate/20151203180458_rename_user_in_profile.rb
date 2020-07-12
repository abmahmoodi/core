class RenameUserInProfile < ActiveRecord::Migration[5.1]
  def change
    rename_column :rw_profiles, :rw_user_id, :user_id
  end
end
