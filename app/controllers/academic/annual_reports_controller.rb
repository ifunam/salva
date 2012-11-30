class Academic::AnnualReportsController < Academic::ApplicationController
  respond_to :js, :html
  layout 'academic'

  def index
    respond_with(@documents = Document.annual_reports.where(:approved_by_id => current_user.id).page(params[:page] || 1).per(10))
  end

  def approve
    authorize_action!
    @document.approve
    respond_with(@document)
  end

  def edit
    authorize_action!
    respond_with(@document)
  end

  def update
    authorize_action!
    @document.update_attributes(params[:document], :as => :academic)
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
