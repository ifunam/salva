class Public::RecentPublicationsController < ActionController::Base
  layout  'public'

  def index
    @collections = [
                    { :title => :published_articles, :collection => Article.published.recent },
                    { :title => :inprogress_articles, :collection => Article.inprogress.recent },
                    { :title => :published_books, :collection => Bookedition.published.recent },
                    { :title => :published_chapterinbooks, :collection => Chapterinbook.published.recent }
                    ]
   respond_to do |format|
      format.html { render :action => :index }
    end
  end

end
