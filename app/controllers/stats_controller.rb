
class StatsController < ApplicationController

  def index
  end

  def all_data
    date = Date.parse(params[:date])
    @data = Attraction.all.map do |att|
      { :attraction => att.name, :values => AttractionLog.where("cast(created_at AS DATE) = ? AND name = ?", date, att.name).sort_by(&:created_at) }
    end
  end

end

