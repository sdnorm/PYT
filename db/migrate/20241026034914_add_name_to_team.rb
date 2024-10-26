class AddNameToTeam < ActiveRecord::Migration[8.0]
  def change
    add_column :teams, :name, :string, null: false
  end
end
