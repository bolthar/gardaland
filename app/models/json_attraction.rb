require 'date'
require 'json'
class JsonAttraction
  
  attr_reader :created_at

  def initialize(json_fragment, created_at)
    @json = json_fragment
    @created_at = created_at
  end

  def attesa
    @json["DisplayWaitTime"].to_i
  end

  def nome
    @json["Name"].to_s
  end
   
  def background
    "/assets/background/" + self.nome.gsub(/\s+/, "") + ".png"
  end

  def logo
    "/assets/logo/" + self.nome.gsub(/\s+/, "") + ".png"
  end
  
  def self.all
    return []
    attractions = JSON.load(`fetch_gardaland`)
    created_at  = DateTime.strptime(attractions["Status"].gsub("Stato al: ", "").gsub("*", ""), "%d/%m/%Y - %H:%M:%S")
    attractions = attractions["Attractions"]["Attraction"].select { |x| x["Name"] != "(null)" }.map { |x| JsonAttraction.new(x, created_at) }.sort_by(&:attesa)
    return attractions
  end

end
