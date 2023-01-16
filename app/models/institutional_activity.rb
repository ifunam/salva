class InstitutionalActivity < ActiveRecord::Base
  # attr_accessor :descr, :institution_id, :startyear, :startmonth, :endyear, :endmonth

  validates_presence_of :descr, :institution_id, :startyear
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :user_id, :startyear, :greater_than => 0, :only_integer => true

  belongs_to :institution
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  def to_s
    [descr, institution.name_and_parent_abbrev, start_date, end_date].compact.join(', ')
  end
end
