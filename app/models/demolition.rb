class Demolition < ActiveRecord::Base
  belongs_to :address
  belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number

  def date
    self.date_completed || self.date_started || DateTime.new(0)
  end

 

end
