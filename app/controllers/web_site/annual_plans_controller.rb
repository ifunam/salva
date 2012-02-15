class WebSite::AnnualPlansController < WebSite::ApplicationController
  respond_to :html, :js

  def index
    respond_with @documents = Document.annual_plans.paginated_search(params)
  end
end
