
class ApiController < ApplicationController

  def at
    date = Date.parse(params[:at])
    values = DataPoint.where("cast(date as DATE) = ?", date)
    values = values.group_by(&:attraction_id)
    render :json => values.map { |x| { :attraction_id => x[0], :values => x[1].sort_by(&:date).map do |y|
      { :time => { :hour => y.date_CET.hour, :minute => y.date_CET.min }, :wait_time => y.wait_time } 
    end } }
  end

  def attractions
    render :json => Attraction.all
  end

  def opening_time
    date = Date.parse(params[:at])
    opening = { :from => 10, :to => DataPoint.open_until(date) }
    render :json => opening
  end

end
