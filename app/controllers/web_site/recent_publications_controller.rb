class WebSite::RecentPublicationsController < WebSite::ApplicationController
  layout 'home_page'

  respond_to :html

  def index
    #@collections = [ { :title => :published_articles, :collection => Article.published.verified.current_year } ]
    @collections = [
                    { :title => :published_articles, :collection => Article.published.verified.current_year },
                    { :title => :published_articles, :collection => Article.published.verified.last_year }
                    ]
    respond_with @collections
  end

end
