class Conferencetalk < ActiveRecord::Base
  validates_presence_of :title, :authors, :conference_id, :talktype_id, :talkacceptance_id, :modality_id

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :conference_id, :talktype_id, :talkacceptance_id, :modality_id, :greater_than =>0 , :only_integer => true


  validates_uniqueness_of :conference_id,  :scope => [:title, :authors, :talktype_id]
  belongs_to :conference
  belongs_to :talktype
  belongs_to :talkacceptance
  belongs_to :modality

  has_many :projectconferencetalks

 validates_associated :conference
 validates_associated :talktype
 validates_associated :talkacceptance
 validates_associated :modality
end
