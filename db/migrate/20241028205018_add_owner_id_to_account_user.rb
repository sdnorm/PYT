class AddOwnerIdToAccountUser < ActiveRecord::Migration[8.0]
  def change
    add_reference :account_users, :owner, foreign_key: { to_table: :users }
  end
end
