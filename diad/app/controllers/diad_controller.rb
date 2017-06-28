require 'useragent'

class DiadController < ApplicationController
  before_action :checklogin, only: [ :viewcart, :itemtocart ]
  force_ssl only: [ :viewcart, :itemtocart, :tender, :rmfromcart ]


  def index
    @shows = Show.all
  end

  def news
  end

  def photos
    @image_urls = Array.new
    @image_urls = [ "mainpoolshotWEB.jpg" ]
  end

  def about
  end

  def download
  end

  def tour
  end

  def music
	user_agent = UserAgent.parse(request.user_agent)
  unless user_agent.browser == "Chrome"
    redirect_to diad_musicsimple_path
  end
  end

  def musicsimple
  end

  def viewcart
    @items = current_user.cart.items
    itemsincart = @items.count
    puts "items in cart is here:"
    puts itemsincart
    unless itemsincart.to_i > 0
      flash[:notice] = "No items in cart."
      redirect_to diad_products_path
    end
    cartid = current_user.cart.id
    @total, @subtotal, @tax, @shipping = Item.rmitem(cartid)
    puts "subtotal is here:"
    puts @subtotal
    puts "Tax is here:"
    puts @tax
    puts "shipping is here:"
    puts @shipping
    if @tax.to_i > 99
      @tax = @tax.to_i.to_s.scan(/./)
      @tax = @tax[0..-3].join + '.' + @tax[-2..-1].join
    else
       @tax = @tax.to_i.to_s
       @tax = '0' + '.' + @tax
    end
    @tax = '$' + @tax
      if @subtotal.to_i > 99
        @subtotal = @subtotal.to_i.to_s.scan(/./)
        @subtotal = @subtotal[0..-3].join + '.' + @subtotal[-2..-1].join
      end
        @subtotal = '$' + @subtotal.to_s
    if current_user.cart.total.to_i > 99
      @total = current_user.cart.total.to_i.to_s.scan(/./)
      @total = @total[0..-3].join + '.' + @total[-2..-1].join
    end
    @total = '$' + @total.to_s
    if @shipping.to_i > 99
      @shipping = @shipping.to_i.to_s.scan(/./)
      @shipping = @shipping[0..-3].join + '.' + @shipping[-2..-1].join
      @shipping = '$' + @shipping.to_s
    end
  end

  def emptycart
    current_user.cart.items.delete_all
    current_user.cart.total = 0
    current_user.cart.save
  end

  def itemtocart
      params[:cartid] = current_user.cart.id
      quantity = params[:quantity]
      params[:size] ||= nil
      if quantity[0] == ""
        quantity[0] = 1
      end
      @total = Item.additem(params[:itemid], quantity[0], params[:cartid], params[:size])
      redirect_to diad_products_path, notice: "Successfully Added to Cart"
  end

  def items
    @items = Item.all
    unless current_user.nil?
       unless Cart.find_by_user_id(current_user.id).nil?
        if current_user.cart.total.to_i > 99
         @total = current_user.cart.total.to_i.to_s.scan(/./)
         @total = @total[0..-3].join + '.' + @total[-2..-1].join
          end
       else
         cartparams = Hash.new
         cartparams[:user_id] = current_user.id
         cartparams[:total] = 0
         Cart.create(cartparams)
         @total = current_user.cart.total.to_i
       end
    else
      @total = 0
    end
  end

  def rmfromcart
       puts "I'm inside of rmfromcart now"
       cartid = current_user.cart.id
      item = Item.find_by_id(params[:id]).delete
       @total, @subtotal, @tax, @shipping = Item.rmitem(cartid)
       if @total.to_i > 0
      redirect_to diad_store_viewcart_path
       else
         flash[:notice] = "Cart is empty, pick your poison."
         redirect_to diad_products_path
         end
  end

  def tender
    if current_user.cart.total.to_i > 99
#    @total = current_user.cart.total.to_i
      cartid = current_user.cart.id
      @total, @subtotal, @tax, @shipping = Item.rmitem(cartid)
      puts "debug---"
      puts @total
      puts @subtotal
      puts @tax.to_i
      puts @shipping
      puts "debug----"
     @total = (@total.to_i + @tax.to_i + @shipping.to_i)
    @total = @total.to_s.scan(/./)
    @displaytotal = '$' + @total[0..-3].join + '.' + @total[-2..-1].join
    else
      flash[:notice] = 'No items in cart.'
      redirect_to diad_products_path
      end
  end

  def videos
  end

  def thankyou
  end

  def checklogin
    unless current_user 
      redirect_to log_in_path
    end
  end


end

