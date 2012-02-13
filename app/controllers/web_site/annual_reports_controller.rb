class WebSite::AnnualReportsController < WebSite::ApplicationController
  respond_to :html, :js

  def index
    @documents = Document.annual_reports.paginated_search(params)
    respond_with(@documents)
  end
end
