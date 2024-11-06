class ModifyDobColumnType < ActiveRecord::Migration[7.1]
  def up
    change_column :players, :dob, :text
  end

  def down
    change_column :players, :dob, :datetime
  end
end 