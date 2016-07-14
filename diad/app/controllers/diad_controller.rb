require 'useragent'

class DiadController < ApplicationController
  before_action :checklogin, only: [ :store, :itemtocart ]

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

  def store
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
      @total = current_user.cart.total.to_i
    end
  end

  def rmitemfromcart
     # item = Item.find_by_id(params[:item])
     # current_user.cart.items
  end

  def videos
  end

  def checklogin
    unless current_user 
      redirect_to log_in_path
    end
  end


end

