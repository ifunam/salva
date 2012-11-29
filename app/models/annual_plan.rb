class AnnualPlan < ActiveRecord::Base
  validates_presence_of :body, :documenttype_id
  attr_accessible :body, :documenttype_id, :user_id
  belongs_to :user
  belongs_to :documenttype
end
