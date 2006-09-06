require 'composed_keys'
class Permission < ActiveRecord::Base
  set_primary_keys :roleingroup_id, :controller_id
  validates_numericality_of :roleingroup_id, :controller_id
#  validates_presence_of :action_id
  belongs_to  :roleingroup
  belongs_to :controller
end
