class WebSite::AnnualPlansController < WebSite::ApplicationController
  respond_to :html, :js

  def index
    @documents = Document.annual_plans.is_not_hidden.fullname_asc.search(params[:search]).paginate(:per_page => params[:per_page] || 30, :page => params[:page] || 1)
    respond_with(@documents)
  end
end
