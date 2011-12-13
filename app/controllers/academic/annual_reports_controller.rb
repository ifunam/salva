class Academic::AnnualReportsController < Academic::ApplicationController
  respond_to :html, :only => :index
  respond_to :js

  def index
    respond_with(@documents = Document.annual_reports.where(:approved_by_id => current_user.id).paginate(:per_page => 10, :page => params[:page] || 1))
  end

  def approve
    authorize_action!
    @document.approve
    respond_with(@document)
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