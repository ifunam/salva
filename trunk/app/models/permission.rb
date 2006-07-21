class Permission < ActiveRecord::Base
#  attr_accessor :action_id_tmp
#  before_create :prepare_action_id
#  after_validation_on_update :prepare_action_id

  belongs_to  :roleingroup
  belongs_to :controller

#   def prepare_action_id
#     self.action_id = self.action_id_tmp
#     self.action_id_tmp = nil
#   end
  
end
