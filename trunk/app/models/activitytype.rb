class Activitytype < ActiveRecord::Base
validates_presence_of :name, :activitygroup_id
validates_numericality_of :activitygroup_id
belongs_to :activitygroup
end
