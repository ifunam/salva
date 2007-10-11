class InstitutionalActivity < ActiveRecord::Base
  validates_presence_of :descr, :institution_id, :startyear
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :user_id, :startyear, :greater_than => 0, :only_integer => true

  #validates_uniqueness_of :institution_id, :scope => [:user_id, :descr, :startyear]

  belongs_to :institution
  belongs_to :user
  validates_associated :institution
  validates_associated :user
end
