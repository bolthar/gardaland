

class HomeController < ApplicationController

  def index
    @attractions = JsosonnAttraction.all
  end

end
