class WebSite::RecentPublicationsController < WebSite::ApplicationController
  layout 'home_page'

  respond_to :html

  def index
    @collections = [
                    { :title => :published_articles, :collection => Article.published.verified.recent }
                    ]
    respond_with @collections
  end

end
