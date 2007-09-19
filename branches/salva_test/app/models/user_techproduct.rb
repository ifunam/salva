class UserTechproduct < ActiveRecord::Base
  validates_presence_of :techproduct_id, :year
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :techproduct_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :userrole_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :year, :only_integer => true

  validates_uniqueness_of :techproduct_id, :scope => [:user_id, :userrole_id, :year]

  belongs_to :techproduct
  belongs_to :userrole
end
