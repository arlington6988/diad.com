class AddAgeToShowTable < ActiveRecord::Migration
  def change
    add_column :shows, :age, :string
  end
end
