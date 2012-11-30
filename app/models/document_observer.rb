class DocumentObserver < ActiveRecord::Observer
  def after_create(document)
    if document.user.user_incharge_id.nil? and document.approved_by_id.nil?
      document.update_attribute(:approved, true)
      Notifier.approved_document(document.id).deliver
    else
      Notifier.approval_request_to_user(document.id).deliver
      Notifier.approval_request_to_user_incharge(document.id).deliver
    end
  end
  
  def after_update(document)
    if !document.approved_by_id.nil? and document.approved == true
      Notifier.approved_document(document.id).deliver
    elsif !document.approved_by_id.nil? and document.approved == false
      Notifier.rejected_document(document.id).deliver
    end
  end

end
