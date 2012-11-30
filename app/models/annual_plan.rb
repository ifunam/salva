class AnnualPlan < ActiveRecord::Base
  validates_presence_of :body, :documenttype_id
  attr_accessible :body, :documenttype_id, :user_id, :delivered
  belongs_to :user
  belongs_to :documenttype

  def deliver
    update_attribute :delivered, true
  end
end
