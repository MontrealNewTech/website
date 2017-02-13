class CreateTeams < ActiveRecord::Migration[5.0]
  def up
    create_table :teams do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end

    drop_table :team_members
    remove_column :users, :first_name
    remove_column :users, :last_name

    create_table :member_profiles do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.string :name
      t.string :position
      t.text :bio

      t.timestamps
    end
  end

  def down
    drop_table :teams, force: :cascade
    drop_table :member_profiles, force: :cascade
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    create_table :team_members do |t|
      t.references :user, foreign_key: true
      t.text :bio
      t.string :position
      t.string :slug

      t.timestamps
    end
  end
end
