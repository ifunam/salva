class WebSite::RecentPublicationsController < WebSite::ApplicationController
  layout 'home_page'

  respond_to :html

  def index
    @collections = [
                    { :title => :published_articles, :collection => Article.where(:year => Date.today.year).published.verified }
                    ]
    respond_with @collections
  end

end
