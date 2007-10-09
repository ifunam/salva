class UserResearchline < ActiveRecord::Base
<<<<<<< .mine
  validates_presence_of :researchline_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0,:onlu_integer => true
  validates_numericality_of :researchline_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true


=======
  validates_presence_of :researchline_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :researchline_id, :user_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:researchline_id]

>>>>>>> .r1716
  belongs_to :researchline
  belongs_to :user

<<<<<<< .mine
  validates_associated :researchline
  validates_associated :user

=======
  validates_associated :researchline
  validates_associated :user
>>>>>>> .r1716
end

