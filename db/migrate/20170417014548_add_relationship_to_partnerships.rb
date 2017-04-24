class AddRelationshipToPartnerships < ActiveRecord::Migration[5.0]
  def change
    add_column :partnerships, :relationship, :string, default: 'community_partner', null: false
  end
end
