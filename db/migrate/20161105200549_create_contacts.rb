class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :email, null: false
      t.string :name
      t.inet :remote_ip
      t.integer :source

      t.timestamps
    end
  end
end
