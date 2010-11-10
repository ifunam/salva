class ArticlesController < PublicationController
  defaults :user_role_class => :user_articles

  def index
    params[:search] ||= {}
    params[:search].merge!(:user_id_eq => current_user.id)
    respond_with (@articles = Article.published.paginated_search(params))
  end

  def not_mine
    params[:search] ||= {}
    params[:search].merge!(:user_id_not_eq => current_user.id)
    respond_with (@articles = Article.published.paginated_search(params))
  end
end
