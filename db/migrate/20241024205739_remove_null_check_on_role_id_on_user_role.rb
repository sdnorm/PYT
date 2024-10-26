class RemoveNullCheckOnRoleIdOnUserRole < ActiveRecord::Migration[8.0]
  def change
    change_column_null :user_roles, :role_id, true
  end
end
