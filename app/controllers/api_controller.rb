
class ApiController < ApplicationController

  def at
    date = Date.parse(params[:at])
    values = DataPoint.where("cast(date as DATE) = ?", date)
    render :json => values.group_by(&:attraction)
  end

  def attractions
    render :json => Attraction.all
  end

end
