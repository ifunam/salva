class WebSite::AnnualReportsController < WebSite::ApplicationController
  respond_to :html, :js

  def index
    respond_with @documents = Document.annual_reports.paginated_search(params)
  end
end
