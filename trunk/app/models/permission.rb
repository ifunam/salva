class Permission < ActiveRecord::Base
  validates_presence_of :roleingroup_id, :controller_id, :action_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :action_id,  :roleingroup_id, :controller_id, :greater_than =>0 , :only_integer => true

  validates_uniqueness_of :roleingroup_id, :scope => [:controller_id, :action_id]

  belongs_to  :action
  belongs_to  :roleingroup
  belongs_to  :controller

  validates_associated :controller
  validates_associated :roleingroup
  validates_associated :action

end
