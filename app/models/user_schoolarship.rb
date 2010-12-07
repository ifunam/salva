class UserSchoolarship < ActiveRecord::Base
  validates_presence_of :schoolarship_id, :start_date
  validates_numericality_of :schoolarship_id, :allow_nil => false,  :greater_than => 0, :only_integer => true
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true

  belongs_to :schoolarship
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  default_scope :order => 'startyear DESC, startmonth DESC, endyear DESC, endmonth DESC'
  def as_text
    [schoolarship.name_and_institution_abbrev, start_date, end_date].compact.join(', ')
  end
end
