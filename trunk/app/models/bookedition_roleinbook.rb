class BookeditionRoleinbook < ActiveRecord::Base
   validates_presence_of :roleinbook_id
   validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
   validates_numericality_of :roleinbook_id, :greater_than => 0, :only_integer => true
   #validates_uniqueness_of :user_id, :scope => [:bookedition_id, :roleinbook_id]

   belongs_to :bookedition
   belongs_to :roleinbook
   belongs_to :user

   #validates_associated  :user_id


end
