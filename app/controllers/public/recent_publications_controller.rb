class Public::RecentPublicationsController < ActionController::Base
  layout  'public'

  def index
    @collections = [
                    { :title => :published_articles, :collection => Article.recent.published },
                    { :title => :inprogress_articles, :collection => Article.recent.inprogress },
                    { :title => :published_books, :collection => Bookedition.recent.published },
                    { :title => :published_chapterinbooks, :collection => Chapterinbook.recent.published }
                    ]
   respond_to do |format|
      format.html { render :action => :index }
    end
  end

end
