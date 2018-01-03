

class HomeController < ApplicationController

  def index
    if File.exist?("/tmp/ranked")
      render :lol and return
    end
    @attractions = JsonAttraction.all
  end

  def adachetoest
  end

end
