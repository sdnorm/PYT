class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :dob
      t.boolean :minor
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
