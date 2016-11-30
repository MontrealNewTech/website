class CreateInitiatives < ActiveRecord::Migration[5.0]
  def change
    create_table :initiatives do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :link

      t.timestamps
    end
  end
end
