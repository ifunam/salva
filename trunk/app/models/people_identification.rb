class PeopleIdentification < ActiveRecord::Base
  validates_presence_of :identification_id, :descr

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :user_id, :identification_id, :greater_than =>0, :only_integer => true


  validates_uniqueness_of :user_id, :scope => [:identification_id]

  belongs_to :identification
  belongs_to :user

  validates_associated :user
end
