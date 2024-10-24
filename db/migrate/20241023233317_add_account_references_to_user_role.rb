class AddAccountReferencesToUserRole < ActiveRecord::Migration[8.0]
  def change
    add_reference :user_roles, :account, null: false, foreign_key: true
  end
end
