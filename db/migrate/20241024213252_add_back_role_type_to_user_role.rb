class AddBackRoleTypeToUserRole < ActiveRecord::Migration[8.0]
  def change
    add_column :user_roles, :role_type, :string
    add_index :user_roles, [ :role_type, :role_id ]
  end
end
