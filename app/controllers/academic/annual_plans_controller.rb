class Academic::AnnualPlansController < Academic::ApplicationController

  def index
    @documents = Document.annual_plans.where(:approved_by_id => current_user.id).all
  end

  def approve
    authorize_action!
    respond_with(@document.approve)
  end

  def reject
    authorize_action!
    respond_with(@document.reject)
  end

  def authorize_action!
    @document = Document.find(params[:id])
    unless @document.approved_by_id == current_user.id
      authorize! :read, Document, :message => "Unable to approve or reject this document."
    end
  end
end