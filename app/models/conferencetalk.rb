class Conferencetalk < ActiveRecord::Base
  validates_presence_of :title, :authors, :talktype_id, :talkacceptance_id, :modality_id

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :talktype_id, :talkacceptance_id, :modality_id, :greater_than =>0 , :only_integer => true

  belongs_to :conference
  belongs_to :talktype
  belongs_to :talkacceptance
  belongs_to :modality
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :user_conferencetalks
end
