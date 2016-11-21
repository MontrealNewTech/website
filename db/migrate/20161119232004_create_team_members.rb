class CreateTeamMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_members do |t|
      t.references :user, foreign_key: true
      t.text :bio
      t.string :position
      t.string :slug

      t.timestamps
    end
  end
end
