class Item < ActiveRecord::Base
   belongs_to :cart

  def self.additem(itemid, quantity, cartid)
    params = Hash.new
    total = 0
    unless itemid.nil?
      quantity = quantity.to_i
      quantity.times {
        params[:cart_id] = cartid
        params[:id] = itemid
        @product = Item.find_by_id(params[:id]).dup
        @product.update(params)
      }
    end
    @cart = Cart.find_by_id(params[:cart_id])
    prices = Array.new
      @cart.items.each do |p|
        prices.push(p.price.to_i)
      end
       prices.each { |a| total+=a }
    puts "Total should be below line:"
    puts total
       @cart.total = total
       @cart.save
      return total

    else
     puts "there was an issue processing your request due to id being nil for product"
  end

end
