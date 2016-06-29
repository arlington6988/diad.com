class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :date
      t.string :venue
      t.string :city
      t.string :tickets
      t.string :directions

      t.timestamps null: false
    end
  end
end
