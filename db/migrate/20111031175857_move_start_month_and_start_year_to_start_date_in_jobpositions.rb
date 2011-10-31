class MoveStartMonthAndStartYearToStartDateInJobpositions < ActiveRecord::Migration
  def self.up
    execute "DROP TRIGGER  IF EXISTS jobposition_delete ON jobpositions"
    execute "DROP TRIGGER  IF EXISTS jobposition_update ON jobpositions"
    Jobposition.all.each do |record|
      unless record.startyear.nil?
        start_year = record.startyear
        start_month = record.startmonth.to_i == 0 ? 1 : record.startmonth
        record.start_date = Date.new(start_year, start_month, 1)
      end

      unless record.endyear.nil?
        end_month = record.endmonth.to_i == 0 ? 1 : record.endmonth
        record.start_date = Date.new(record.endyear, end_month, 27)
      end
      record.save
    end
  end

  def self.down
  end
end
