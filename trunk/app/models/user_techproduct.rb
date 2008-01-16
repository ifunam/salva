class UserTechproduct < ActiveRecord::Base
  validates_presence_of :year
  validates_numericality_of :id, :techproduct_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :userrole_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :techproduct
  belongs_to :userrole

end
