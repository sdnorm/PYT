class ChangeNameToIntegerOnUserRole < ActiveRecord::Migration[8.0]
  def change
    change_column :user_roles, :name, :integer, using: "name::integer"
  end
end
