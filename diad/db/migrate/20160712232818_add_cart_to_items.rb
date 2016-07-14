class AddCartToItems < ActiveRecord::Migration
  def change
    add_reference :items, :cart, index: true
  end
end
