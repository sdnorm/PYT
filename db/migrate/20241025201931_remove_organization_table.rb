class RemoveOrganizationTable < ActiveRecord::Migration[8.0]
  def change
    remove_column :tournaments, :organization_id
    remove_column :teams, :organization_id
    drop_table :organizations
  end
end
