class UserConferencetalk < ActiveRecord::Base
#  set_table_name "user_conferencetalks"
#  set_primary_keys :user_id, :conferencetalk_id

  validates_numericality_of :id, :conferencetalk_id, :allow_nil => true,:greater_than => 0, :only_integer => true
  validates_presence_of :roleinconferencetalk_id
  validates_numericality_of :conferencetalk_id, :user_id, :roleinconferencetalk_id, :greater_than =>0 , :only_integer => true


  validates_uniqueness_of :user_id, :scope => [:conferencetalk_id, :roleinconferencetalk_id], :message => 'El rol del usuario esta duplicado'

  belongs_to :conferencetalk
  belongs_to :roleinconferencetalk
  belongs_to :user

  validates_associated :conferencetalk
  validates_associated :roleinconferencetalk


end
