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

end
