class Period < ActiveRecord::Base
  validates_presence_of :name, :startdate, :enddate
end
