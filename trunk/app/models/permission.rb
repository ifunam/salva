class Permission < ActiveRecord::Base
  belongs_to  :roleingroup
  belongs_to :controller
  belongs_to :actino
end
