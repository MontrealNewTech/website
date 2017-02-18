class RenameOrganizationsPartnerships < ActiveRecord::Migration[5.0]
  def change
    rename_table :organizations, :partnerships
  end
end
