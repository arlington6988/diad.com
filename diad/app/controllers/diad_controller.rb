require 'useragent'

class DiadController < ApplicationController
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

  def videos
  end




end

