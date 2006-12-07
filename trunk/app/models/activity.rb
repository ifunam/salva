class Activity < ActiveRecord::Base
validates_presence_of :activitytype_id, :name
validates_numericality_of :activitytype_id
belongs_to :activitytype
end
