class AddShebaToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column(:rw_profiles, :sheba, :string)
  end
end
