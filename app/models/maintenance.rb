class Maintenance < ActiveRecord::Base
  #this is for abatement programs like INAP
  belongs_to :address

  def date
    self.date_completed || DateTime.new(0)
  end

  def self.import_from_workbook(workbook, sheet)
    sheet.each do |row|
      begin
        r_date = workbook.num_to_date(row[5].value.to_i)
        c_date = workbook.num_to_date(row[7].value.to_i)
        Maintenance.create(:house_num => row[0].value, :street_name => row[1].value, :street_type => AddressHelpers.get_street_type(row[2].value), :address_long => AddressHelpers.abbreviate_street_types(row[3].value), :date_recorded => r_date, :date_completed => c_date, :program_name => row[10].value, :status => row[9].value)
      rescue
        p "Maintenance could not be saved: #{$!}"
        p row
      end
    end
  end
end
