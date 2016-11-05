class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :logo

      t.timestamps
    end
  end
end
