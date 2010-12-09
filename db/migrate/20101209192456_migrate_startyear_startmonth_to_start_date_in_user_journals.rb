class MigrateStartyearStartmonthToStartDateInUserJournals < ActiveRecord::Migration
  def self.up
    UserSchoolarship.all.each do |record|
      if record.startyear.is_a? Integer
        record.start_date = Date.new(record.startyear, record.startmonth || 1, 1)
      end
      if record.endyear.is_a? Integer
        record.end_date = Date.new(record.endyear, record.endmonth || 12, 27)
      end
      record.save
    end
  end

  def self.down
    UserSchoolarship.all.each do |record|
      if record.start_date.is_a? Date
        record.startmonth = record.start_date.month
        record.startyear = record.start_date.year
      end
      if record.end_date.is_a? Date
        record.endmonth = record.end_date.month
        record.endyear = record.end_date.year
      end
      record.start_date = record.end_date = nil
      record.save
    end
  end
end
