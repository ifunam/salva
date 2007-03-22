class Period < ActiveRecord::Base
validates_presence_of :title, :startdate, :enddate
end
