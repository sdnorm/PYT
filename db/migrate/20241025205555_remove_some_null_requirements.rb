class RemoveSomeNullRequirements < ActiveRecord::Migration[8.0]
  def change
    change_column_null :user_roles, :account_id, true

    add_reference :user_roles, :team, foreign_key: true
    add_reference :user_roles, :tournament, foreign_key: true
  end
end
