
def get_times_starting_at(starting_time) #nasty
  result = []
  while !(starting_time.hour == DataPoint.open_until(starting_time) && starting_time.min == 00)
    result << starting_time
    starting_time += 30.minutes
  end
  return result
end

namespace :log do
 
  task :register => :environment do
    attractions = JsonAttraction.all
    date_format = "%d/%m/%Y - %H:%M:%S"
    file_name   = File.dirname(__FILE__) + "/last_date"
    current_date = attractions.first.created_at
    past_date    = DateTime.strptime(File.read(file_name), date_format)
    if current_date > past_date
      attractions.each do |att|
        log = AttractionLog.new
        log.name = att.nome
        log.wait_time = att.attesa.to_i
        log.save
      end
      File.delete(file_name)
      File.write(file_name, current_date.strftime(date_format))
    end
  end

  task :process => :environment do

    last_processed = DataPoint.order(:date).last
    start_date = nil
    if last_processed
      start_date = Time.new(last_processed.date.year, last_processed.date.month, last_processed.date.day) + 1.day
    else
      start_date = AttractionLog.order(:created_at).first.created_at
    end
    end_date = Time.new(Time.now.year, Time.now.month, Time.now.day) - 1.minute

    Attraction.all.each do |att|
      opening_time = Time.new(start_date.year, start_date.month, start_date.day, att.opened_from, 30, 0).utc
      while opening_time < end_date
        get_times_starting_at(opening_time).each do |time|
	  logs = AttractionLog.where("name = ? AND created_at BETWEEN ? AND ?", att.name, time - 30.minutes, time + 30.minutes)
          if logs.any?
            data_point = DataPoint.new
            data_point.attraction = att
            data_point.wait_time = logs.sum { |x| x.wait_time } / logs.count
            data_point.date = time
            data_point.save
	  end
        end
	opening_time = opening_time + 1.day
      end
    end

  end

end
