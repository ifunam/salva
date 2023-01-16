class AnnualPlan < ActiveRecord::Base
  validates_presence_of :body, :documenttype_id
  # attr_accessor :body, :documenttype_id, :user_id, :delivered
  belongs_to :user
  belongs_to :documenttype

  def deliver
    update_attribute :delivered, true
  end

  def undelivered_or_rejected?
    if user.user_incharge_id.nil?
      !delivered?
    else
      @document = Document.search(:user_id_eq => user.id, :documenttype_id_eq => documenttype_id, :approved_eq => false, :approved_by_id_is_not_null => true, :comments_is_not_null => true).first
      (!@document.nil? and delivered?) or (@document.nil? and !delivered?)
    end
  end
end
