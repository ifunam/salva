class MissingPlan < ActiveRecord::Base
  scope :all, lambda { where("userstatus_id=2") }
  belongs_to :user
  belongs_to :documenttype
end
