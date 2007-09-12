class InstitutionalActivity < ActiveRecord::Base
  validates_presence_of :descr, :institution_id, :user_id, :startyear

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :startyear, :only_integer => true

  #validates_uniqueness_of :institution_id, :scope => [:user_id, :descr, :startyear]

  belongs_to :institution
  belongs_to :user
end
