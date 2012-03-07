class Education < ActiveRecord::Base
  attr_accessible :startyear, :endyear, :is_studying_this, :is_titleholder, :career_attributes

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
  scope :since, lambda { |year| where{{:startyear.gteq => year}} }
  scope :until, lambda { |year| where{{:endyear.lteq => year}} }
  scope :among, lambda { |start_year, end_year| since(start_year).until(end_year) }

  search_methods :since, :until
  search_methods :among, :splat_param => true, :type => [:integer, :integer]

  def as_text
    [career.as_text, startyear, endyear].compact.join(', ')
  end
end
