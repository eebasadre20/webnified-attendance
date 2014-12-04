class AddStatus < ActiveRecord::Migration
  def up
  	add_column :heros, :status, :boolean, :default => true
  end

  def down
  	remove_column :heros, :status
  end
end
