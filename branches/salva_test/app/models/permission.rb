class Permission < ActiveRecord::Base
  validates_presence_of :roleingroup_id, :controller_id, :action_id
  validates_numericality_of :roleingroup_id, :controller_id,  :action
  validates_uniqueness_of :roleingroup, :scope => [:controller_id, :action_id]
  belongs_to :action
  belongs_to :roleingroup
  belongs_to :controller
end
