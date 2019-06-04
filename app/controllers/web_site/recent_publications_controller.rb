class WebSite::RecentPublicationsController < WebSite::ApplicationController
  layout 'home_page'

  respond_to :html

  def index
    @data = []
    @data.concat(Article.published.verified.current_year)
    @data.concat(Article.published.verified.last_year)

    @collections = [
                    { :title => :published_articles, :collection => @data }#,
                    ]
    respond_with @collections
  end

end
