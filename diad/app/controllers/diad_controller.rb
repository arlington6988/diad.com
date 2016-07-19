require 'useragent'

class DiadController < ApplicationController
  before_action :checklogin, only: [ :viewcart, :itemtocart ]

  def index
    @shows = Show.all
  end

  def news
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
    itemsincart = current_user.cart.items.count
    if itemsincart.nil? or itemsincart == '0'
      redirect_to diad_products_path, notice: "You have no items in the cart to view, add something."
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

    @total = Item.additem(params[:itemid], quantity[0], params[:cartid])
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
      @total = "Cart is empty, not logged in."
    end
  end

  def rmitemfromcart
      item = Item.find_by_id(params[:item]).delete
      redirect_to diad_store_viewcart
  end

  def tender
    @total = current_user.cart.total.to_i
    @total = @total.to_s.scan(/./)
    @displaytotal = @total[0..-3].join + '.' + @total[-2..-1].join
  end

  def videos
  end

  def checklogin
    unless current_user 
      redirect_to log_in_path
    end
  end


end

