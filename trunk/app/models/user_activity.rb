class UserActivity < ActiveRecord::Base
validates_presence_of :activity_id, :startyear
validates_numericality_of :userrole_id, :activity_id
belongs_to :userrole
belongs_to :activity
end
