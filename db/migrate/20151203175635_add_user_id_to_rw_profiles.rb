class AddUserIdToRwProfiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :rw_profiles, :rw_user, index: true, foreign_key: true
  end
end
