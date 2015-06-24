
class DataPoint < ActiveRecord::Base
   
  belongs_to :attraction

  def date_CET
    return self.date + 2.hour
  end

  def self.open_until(date)
    if date.month > 5 && date.month < 10
      if date.month == 7 ||
  	 date.month == 8 ||
	 (date.month == 6 && date.day > 19) ||
	 (date.month == 9 && date.day < 14)
        return 23
      end
    end
    return 18
  end

end
