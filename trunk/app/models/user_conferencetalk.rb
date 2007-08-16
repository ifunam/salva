class UserConferencetalk < ActiveRecord::Base
#  set_table_name "user_conferencetalks"
#  set_primary_keys :user_id, :conferencetalk_id
  validates_presence_of :roleinconferencetalk_id
  validates_numericality_of :conferencetalk_id, :roleinconferencetalk_id
  validates_uniqueness_of :user_id, :scope => [:conferencetalk_id, :roleinconferencetalk_id]

  belongs_to :conferencetalk
  belongs_to :roleinconferencetalk
end
