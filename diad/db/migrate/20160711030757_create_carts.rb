class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.decimal :total
      t.text :items, array:true, default: []

      t.timestamps null: false
    end
  end
end
