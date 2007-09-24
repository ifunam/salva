class BookeditionRoleinbook < ActiveRecord::Base
  validates_presence_of :bookedition_id, :roleinbook_id, :user_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :bookedition_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleinbook_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [ :bookedition_id, :roleinbook_id ]  

  belongs_to :bookedition
  belongs_to :roleinbook
  belongs_to :user
end
