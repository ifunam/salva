class Permission < ActiveRecord::Base
  validates_presence_of :roleingroup_id, :controller_id, :action_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :action_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleingroup_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :controller_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :roleingroup_id, :scope => [:controller_id, :action_id]

  belongs_to  :action
  belongs_to  :roleingroup
  belongs_to  :controller
end
