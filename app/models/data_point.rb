
class DataPoint < ActiveRecord::Base
   
  belongs_to :attraction

  def date_CET
    return self.date + 2.hour
  end

end
