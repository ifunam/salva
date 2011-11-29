class TutorialCommittee < ActiveRecord::Base
  validates_presence_of :studentname,  :year
  validates_numericality_of :id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :career
  accepts_nested_attributes_for :career
  belongs_to :institutioncareer # FIX IT: Remove this relationship until next release.
                                # We need institutioncareers table to support
                                # migrations from previous versions of salva databases.

  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  default_scope :order => ('year DESC, studentname ASC')

  def as_text
    ["#{studentname} (estudiante)", career.as_text, year].compact.join(', ')
  end
end
