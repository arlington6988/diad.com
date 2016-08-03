class Item < ActiveRecord::Base
   belongs_to :cart

  def self.additem(itemid, quantity, cartid)
    params = Hash.new
    total = 0
    subtotal = 0
    shipping = 0
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
    puts "Subtotal should be below line:"
    tax = total * 0.07
    subtotal = (tax.to_i + total.to_i)
    puts subtotal
    shipping = @cart.items.count * 100
       @cart.total = total
       @cart.save
      return total, subtotal, tax, shipping

    else
     puts "there was an issue processing your request due to id being nil for product"
  end

  def self.rmitem(cartid)
    total = 0
    subtotal = 0
    @cart = Cart.find_by_id(cartid)
    prices = Array.new
      @cart.items.each do |p|
        prices.push(p.price.to_i)
      end
        prices.each { |a| total+=a }
        puts "Total should be below line:"
        puts total
        puts "Subtotal should be below line:"
        tax = total.to_i * 0.07
        shipping = @cart.items.count * 100
        subtotal = (total.to_i + tax.to_i + shipping.to_i)
        puts subtotal
       @cart.total = total
       @cart.save
      return total, subtotal, tax, shipping
      end
  end
