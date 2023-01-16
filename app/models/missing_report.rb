class MissingReport < ActiveRecord::Base
  scope :toberenamed, lambda { where("userstatus_id=2") } # :all is a reserved scope, please see how changing this affects the app
  belongs_to :user
  belongs_to :documenttype
end
