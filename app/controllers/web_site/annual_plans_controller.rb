class WebSite::AnnualPlansController < WebSite::ApplicationController
  respond_to :html, :js

  def index
    @documents = Document.annual_plans.paginated_search(params)
    respond_with(@documents)
  end
end
