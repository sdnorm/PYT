class CreateTournaments < ActiveRecord::Migration[8.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.references :account, null: false, foreign_key: true
      t.references :organization, null: true, foreign_key: true

      t.timestamps
    end
  end
end
