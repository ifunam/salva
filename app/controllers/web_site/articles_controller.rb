class WebSite::ArticlesController < WebSite::ApplicationController
  respond_to :html

  def index
    respond_with(@articles = Article.all.paginate(:per_page => 10, :page => 1))
  end
end