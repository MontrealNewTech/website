class MakeMemberProfileUserNullable < ActiveRecord::Migration[5.0]
  def up
    change_column :member_profiles, :user_id, :integer, null: true
  end

  def down
    change_column :member_profiles, :user_id, :integer, null: false
  end
end
