class CreateUserRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, polymorphic: true, null: false
      t.string :name

      t.timestamps
    end
    add_index :user_roles, [ :user_id, :role_type, :role_id, :name ], unique: true, name: 'index_user_roles_on_user_and_role'
  end
end
