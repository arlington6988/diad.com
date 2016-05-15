class CreateFans < ActiveRecord::Migration
  def change
    create_table :fans do |t|
      t.string :name
      t.string :email
      t.integer :zipcode
      t.string :birthday

      t.timestamps null: false
    end
  end
end
