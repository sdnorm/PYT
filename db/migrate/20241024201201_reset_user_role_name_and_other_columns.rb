class ResetUserRoleNameAndOtherColumns < ActiveRecord::Migration[8.0]
  def change
    remove_column :user_roles, :name
    remove_column :user_roles, :role_category
    remove_column :user_roles, :role_type

    add_column :user_roles, :name, :bigint, null: false
  end
end
