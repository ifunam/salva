class Person < ActiveRecord::Base
  set_primary_key "user_id"

  validates_presence_of :firstname,  :lastname1, :dateofbirth, :country_id, :state_id, :city
  validates_numericality_of :country_id, :state_id
  validates_inclusion_of :gender, :in=> [true, false]
  # :message=>"woah! what are you then!??!!"

  belongs_to :user
  belongs_to :maritalstatus
  belongs_to :country
  belongs_to :state
  belongs_to :city

  def fullname
    [self.lastname1, self.lastname2, self.firstname].join(' ')
  end

end
