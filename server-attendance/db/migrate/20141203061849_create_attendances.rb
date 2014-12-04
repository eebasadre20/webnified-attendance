class CreateAttendances < ActiveRecord::Migration
  def up
    create_table :attendances do |t|
      t.datetime	:timein
      t.datetime	:timeout
      t.string 		:photoin
      t.string 		:photoout
      t.boolean		:status, :default => "false"

      t.timestamps
    end
  end

  def down
  	drop_table :attendances
  end
end
