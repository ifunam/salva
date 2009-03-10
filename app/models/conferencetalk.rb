class Conferencetalk < ActiveRecord::Base
  validates_presence_of :title, :authors, :talktype_id, :talkacceptance_id, :modality_id

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :talktype_id, :talkacceptance_id, :modality_id, :greater_than =>0 , :only_integer => true


  #validates_uniqueness_of :conference_id,  :scope => [:title, :authors, :talktype_id]
  belongs_to :conference
  belongs_to :talktype
  belongs_to :talkacceptance
  belongs_to :modality

  has_many :projectconferencetalks

  named_scope :local_scope, :conditions => 'conferences.conferencescope_id = 1', :include => [:conference]
  named_scope :national_scope, :conditions => 'conferences.conferencescope_id = 2', :include => [:conference]
  named_scope :international_scope, :conditions => 'conferences.conferencescope_id = 3', :include => [:conference]
end
