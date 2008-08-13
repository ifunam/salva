class UserCitesLog < ActiveRecord::Base
validates_presence_of :total, :year
end
