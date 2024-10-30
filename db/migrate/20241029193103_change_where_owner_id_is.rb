class ChangeWhereOwnerIdIs < ActiveRecord::Migration[8.0]
  def change
    remove_reference :account_users, :owner, foreign_key: { to_table: :users }

    add_reference :accounts, :owner, foreign_key: { to_table: :users }
  end
end
