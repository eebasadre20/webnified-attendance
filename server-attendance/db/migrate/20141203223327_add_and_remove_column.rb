class AddAndRemoveColumn < ActiveRecord::Migration
  def up
  	add_column :heros, :salt, :string
  end

  def down
  	remove_column :heros, :salt
  end
end
