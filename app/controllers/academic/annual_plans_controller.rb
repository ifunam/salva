class Academic::AnnualPlansController < Academic::ApplicationController
  respond_to :js, :html

  def index
    respond_with(@documents = Document.annual_plans.where(:approved_by_id => current_user.id).paginate(:per_page => 10, :page => params[:page] || 1))
  end

  def approve
    authorize_action!
    respond_with(@document.approve)
  end

  def edit
    authorize_action!
    respond_with(@document)
  end

  def update
    authorize_action!
    @document.update_attributes(params[:document])
    @document.reject
    respond_with(@document)
  end

  def authorize_action!
    @document = Document.find(params[:id])
    unless @document.approved_by_id == current_user.id
      authorize! :read, Document, :message => "Unable to approve or reject this document."
    end
  end
end