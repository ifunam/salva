class UserRoleingroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :roleingroup 
end
