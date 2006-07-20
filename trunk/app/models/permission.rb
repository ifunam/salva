class Permission < ActiveRecord::Base
  belongs_to  :roleingroup
  belongs_to :controller
end
