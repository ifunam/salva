 class Country < ActiveRecord::Base

   @@whiny_protected_attributes = false



  validates_presence_of  :name, :citizen, :code
  validates_numericality_of :id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :code

  has_many :states
  has_many :journals
  has_many :newspapers
  has_many :acadvisits
  has_many :courses
  #before_validation :set_id

  #def set_
  #  self.id = self.attributes_before_type_cast[:id].to_i
  #end
end
