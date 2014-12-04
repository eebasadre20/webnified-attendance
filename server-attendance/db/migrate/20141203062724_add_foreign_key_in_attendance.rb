class AddForeignKeyInAttendance < ActiveRecord::Migration
  def up
  	add_column :attendances, :hero_id, :integer
  	add_index :attendances, :hero_id
  end

  def down
  	remove_column :attendances, :hero_id
  	remove_index :attendances, :hero_id
  end
end
