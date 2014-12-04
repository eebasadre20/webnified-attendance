class CreateHeros < ActiveRecord::Migration
  def up
    create_table :heros do |t|
      t.string :firstname
      t.string :lastname
      t.string :company_position
      t.string :email
      t.string :contact_number
      t.string :gender
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end

  def down
  	drop_table :heros
  end
end
