class UserTechproduct < ActiveRecord::Base
validates_presence_of :techproduct_id, :year
validates_numericality_of :techproduct_id, :userrole_id
belongs_to :techproduct
belongs_to :userrole
end
