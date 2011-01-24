class Education < ActiveRecord::Base
  validates_presence_of  :startyear
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true

  validates_numericality_of :endyear, :credits, :allow_nil => true
  validates_inclusion_of :is_titleholder, :in => [true, false], :if => lambda { |record| record.is_studying_this == false}
  validates_inclusion_of :is_studying_this, :in => [true, false], :if => lambda { |record| record.is_titleholder == false}

  belongs_to :career
  accepts_nested_attributes_for :career
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  belongs_to :institutioncareer # FIX IT: Remove this relationship until next release.
                                # We need institutioncareers table to support
                                # migrations from previous versions of salva databases.
  default_scope :order => 'endyear DESC, startyear DESC'

  def as_text
    [career.as_text, startyear, endyear].compact.join(', ')
  end
end
