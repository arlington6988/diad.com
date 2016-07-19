class AddDisplaypriceToItems < ActiveRecord::Migration
  def change
    add_column :items, :displayprice, :string
  end
end
