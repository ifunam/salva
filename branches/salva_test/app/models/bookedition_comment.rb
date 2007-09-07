class BookeditionComment < ActiveRecord::Base
  validates_presence_of :user_id, :message => "Proporcione el user_id"
  validates_presence_of :bookedition_id, :message => "Proporcione el bookedition_id"

#  validates_numericality_of :institution_id #:jobpositioncategory_id, :contracttype_id, 

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :bookedition_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:bookedition_id]

  belongs_to :bookedition
  belongs_to :user
end
