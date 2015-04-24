

class HomeController < ApplicationController

  def index
    @attractions = JsonAttraction.all
  end

end
