class AddAvatarToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :rw_profiles, :avatar, :string
  end
end
