class Conferencetalk < ActiveRecord::Base
  validates_presence_of :title, :authors, :conference_id, :talktype_id, :talkacceptance_id, :modality_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :conference_id, :only_integer => true
  validates_numericality_of :talktype_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :talkacceptance_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :modality_id, :allow_nil => true, :only_integer => true
  validates_uniqueness_of :conference_id, :title, :authors
  belongs_to :conference
  belongs_to :talktype
  belongs_to :talkacceptance
  belongs_to :modality

  has_many :projectconferencetalks
end
