require 'useragent'

class DiadController < ApplicationController
  before_action :checklogin, only: :items

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

  def items
    @items = Item.all
  end

  def videos
  end

  def checklogin
    unless current_user 
      redirect_to log_in_path
    end
  end


end

