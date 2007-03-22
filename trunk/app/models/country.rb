class Country < ActiveRecord::Base
  validates_numericality_of :id
  validates_presence_of :id, :name, :citizen, :code
  validates_length_of :code, :within => 2..3
  validates_uniqueness_of :name, :code, :id
  
  has_many :state

  before_validation :check_id
  
  def check_id
    if self.id != nil
      errors.add("id", "Invalid range for ID, Valid: 1-999")  if self.id < 1 or self.id > 1000
      return false
    end
  end
  
end
