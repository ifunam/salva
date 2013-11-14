class DocumentObserver < ActiveRecord::Observer
  def after_create(document)
    # TODO: Refactor this block and the document, documenttype and documenty_type model relationship
    if document.document_type_id.nil? # Send the notification if the document_type is related to documents related to a specific period of time (see documenttype, not document_type)
      if document.user.user_incharge_id.nil? and document.approved_by_id.nil?
        document.update_attribute(:approved, true)
        Notifier.approved_document(document.id).deliver
      else
        Notifier.approval_request_to_user(document.id).deliver
        Notifier.approval_request_to_user_incharge(document.id).deliver
      end
    end
  end

  def after_update(document)
    # TODO: Refactor this block and the document, documenttype and documenty_type model relationship
    if document.document_type_id.nil? # Send the notification if the document_type is related to documents related to a specific period of time (see documenttype, not document_type)
      if !document.approved_by_id.nil? and document.approved == true
        Notifier.approved_document(document.id).deliver
      elsif !document.approved_by_id.nil? and document.approved == false
        Notifier.rejected_document(document.id).deliver
      end
    end
  end

end
