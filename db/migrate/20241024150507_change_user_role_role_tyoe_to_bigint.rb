class ChangeUserRoleRoleTyoeToBigint < ActiveRecord::Migration[8.0]
  def change
    change_column :user_roles, :role_type, :bigint, using: "role_type::bigint"
  end
end
