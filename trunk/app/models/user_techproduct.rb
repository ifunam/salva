class UserTechproduct < ActiveRecord::Base
  validates_presence_of :techproduct_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :userrole_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :techproduct_id, :year, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :techproduct_id, :scope => [:userrole_id, :user_id]

  belongs_to :user
  belongs_to :techproduct
  belongs_to :userrole

  validates_associated :user
  validates_associated :techproduct
  validates_associated :userrole
end
