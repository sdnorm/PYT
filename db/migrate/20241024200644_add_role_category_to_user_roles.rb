class AddRoleCategoryToUserRoles < ActiveRecord::Migration[8.0]
  def change
    add_column :user_roles, :role_category, :bigint
    change_column :user_roles, :role_type, :bigint, null: true
  end
end
