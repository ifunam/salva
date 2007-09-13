class PeopleIdentification < ActiveRecord::Base
  validates_presence_of :identification_id, :descr, :user_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :identification_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:identification_id]

  belongs_to :identification
  belongs_to :user
end
