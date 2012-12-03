class AnnualPlan < ActiveRecord::Base
  validates_presence_of :body, :documenttype_id
  attr_accessible :body, :documenttype_id, :user_id, :delivered
  belongs_to :user
  belongs_to :documenttype

  def deliver
    update_attribute :delivered, true
  end

  def undelivered_or_rejected?
    !delivered? or Document.where(:user_id => user_id, :documenttype_id => documenttype_id, :approved => true).nil?
  end
end
