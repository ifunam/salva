class UpdateStartDateAndEndDateIntheses < ActiveRecord::Migration
  def up
    Thesis.all.each do |record|
      start_date, end_date = nil
      start_date = Date.new(record.startyear.to_i, record.startmonth.to_i, 1) if Date.valid_date?(record.startyear.to_i, record.startmonth.to_i, 1) and record.startyear.to_i > 0
      end_date = Date.new(record.endyear.to_i, record.endmonth.to_i, 1) if Date.valid_date?(record.endyear.to_i, record.endmonth.to_i, 1) and record.endyear.to_i > 0
      record.update_attributes(:start_date => start_date, :end_date => end_date)
    end
  end

  def down
    Thesis.all.each do |record|
      record.update_attributes(:startmonth => record.start_date.month, :startyear => record.start_date.year, :endmonth => record.end_date.month, :endyear => record.end_date.year)
    end
  end
end
