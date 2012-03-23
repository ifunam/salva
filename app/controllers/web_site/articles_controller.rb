class WebSite::ArticlesController < WebSite::ApplicationController
  respond_to :html

  def index
    respond_with @articles = Article.all.page(params[:page] || 1).per(10)
  end
end