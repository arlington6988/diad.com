class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.string :size
      t.string :color

      t.timestamps null: false
    end
  end
end
