class AddImageToMemberProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :member_profiles, :image, :string
  end
end
