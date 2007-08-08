class Country < ActiveRecord::Base
 # validates_numericality_of :id, :only_integer => true
  validates_presence_of  :name, :citizen, :code
  validates_uniqueness_of :name, :citizen, :code

  has_many :states
  has_many :journals
  has_many :newspapers
  has_many :acadvisits
  has_many :courses
  before_validation_on_create  :set_id

  def set_id
    self.id = self.attributes_before_type_cast[:id].to_i
  end
end
