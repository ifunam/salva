class UserTechproduct < ActiveRecord::Base
  validates_presence_of :techproduct_id, :year
  validates_numericality_of :techproduct_id, :userrole_id, :user_id
  validates_uniqueness_of :techproduct_id, :scope => [:userrole_id, :user_id]

  belongs_to :user
  belongs_to :techproduct
  belongs_to :userrole
end
