class Person < ActiveRecord::Base
  set_primary_key "user_id"

  validates_presence_of :user_id, :country_id, :firstname,  :lastname1, :dateofbirth
  validates_numericality_of :user_id, :allow_nil => true,  :only_integer => true
  validates_numericality_of :country_id, :allow_nil => true, :only_integer => true
  validates_inclusion_of :gender, :in=> [true, false]
  # :message=>"woah! what are you then!??!!"

  validates_uniqueness_of :user_id

  belongs_to :user
  belongs_to :maritalstatus
  belongs_to :country
  belongs_to :state
  belongs_to :city

  def fullname
    [self.lastname1, self.lastname2, self.firstname].join(' ')
  end

end
