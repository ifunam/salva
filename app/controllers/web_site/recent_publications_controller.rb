class WebSite::RecentPublicationsController < WebSite::ApplicationController
  layout 'home_page'

  respond_to :html

  def index
    @collections = [
                    { :title => :published_articles, :collection => Article.published.recent },
                    { :title => :inprogress_articles, :collection => Article.inprogress.recent },
                    { :title => :published_books, :collection => Bookedition.published.recent },
                    { :title => :published_chapterinbooks, :collection => Chapterinbook.published.recent }
                    ]
    respond_with @collections
  end

end