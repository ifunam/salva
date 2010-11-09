class ArticlesController < ApplicationController
  layout 'publications'

  respond_to :html
  respond_to :js, :only => [:author_list, :add_author, :del_author]

  def index
    default_search = {:user_id => current_user.id }
    respond_with(@articles = Article.published.paginated_search(params))
  end

  def author_list
    respond_with(@article = Article.find(params[:id]))
  end

  def add_author  
    @article = Article.find(params[:id])
    @article.user_articles.create(:user_id => current_user.id)
    respond_with(@article)
  end

  def del_author
    @article = Article.find(params[:id])
    @article.user_articles.where(:user_id => current_user.id).first.destroy
    respond_with(@article)
  end
end
