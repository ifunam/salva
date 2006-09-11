class UserStimulu < ActiveRecord::Base
  set_table_name "user_stimulus"
  validates_presence_of :startyear
  validates_numericality_of :stimuluslevel_id
  belongs_to :stimuluslevel
end
