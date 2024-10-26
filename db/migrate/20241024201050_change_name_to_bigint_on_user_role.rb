class ChangeNameToBigintOnUserRole < ActiveRecord::Migration[8.0]
  def change
    change_column :user_roles, :name, :bigint, using: "name::bigint"
  end
end
