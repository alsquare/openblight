class Inspection < ActiveRecord::Base
  belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number
  belongs_to :inspector

  validates_uniqueness_of :inspection_date, :scope => :case_number

  def date
    self.inspection_date || self.scheduled_date || DateTime.new(0)
  end

  def notes
  	self.result
  end
end
