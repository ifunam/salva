class Person < ActiveRecord::Base
  set_primary_key "user_id"

  validates_numericality_of  :country_id, :greater_than =>0, :only_integer => true
  validates_numericality_of :maritalstatus_id, :city_id, :state_id, :allow_nil => true, :greater_than =>0, :only_integer => true

#  validates_presence_of :firstname,  :lastname1, :dateofbirth, :country_id, :gender

  belongs_to :user
  belongs_to :maritalstatus
  belongs_to :country
  belongs_to :state
  belongs_to :city

#  validates_associated :user
#  validates_associated :maritalstatus
#  validates_associated :country
#  validates_associated :state
#  validates_associated :city

  def fullname
    [self.lastname1, self.lastname2, self.firstname].join(' ')
  end

end
