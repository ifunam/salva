class UserConferencetalk < ModelComposedKeys
  set_table_name "user_conferencetalks"
  set_primary_keys :user_id, :conferencetalk_id
  validates_presence_of :attendeetype_id
  validates_numericality_of :conferencetalk_id, :attendeetype_id
  validates_uniqueness_of :user_id, :scope => [:conferencetalk_id, :attendeetype_id], :message => 'El rol del usuario esta duplicado' 
  belongs_to :conferencetalk
  belongs_to :attendeetype
end
