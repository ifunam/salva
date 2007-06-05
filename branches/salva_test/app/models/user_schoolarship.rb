class UserSchoolarship < ActiveRecord::Base
validates_presence_of :schoolarship_id, :startyear
validates_numericality_of :schoolarship_id
belongs_to :schoolarship
end
