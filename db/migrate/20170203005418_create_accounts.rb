class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.boolean :admin, default: false, null: :false
      t.references :user, foreign_key: true, null: :false

      t.timestamps
    end

    remove_column :users, :role, :integer
  end
end
