class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.datetime :starts_at, null: false
      t.integer :duration
      t.references :location, foreign_key: true
      t.string :cover_image
      t.string :slug

      t.timestamps
    end
  end
end
