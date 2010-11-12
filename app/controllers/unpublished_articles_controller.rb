class UnpublishedArticlesController < PublicationController
  defaults :user_role_class => :user_articles, :resource_class => Article, :collection_name => 'articles', :instance_name => 'article'

  def index
    params[:search] ||= {}
    params[:search].merge!(:user_id_eq => current_user.id)
    respond_with (@articles = Article.unpublished.paginated_search(params))
  end

  def not_mine
    params[:search] ||= {}
    params[:search].merge!(:user_id_not_eq => current_user.id)
    respond_with (@articles = Article.unpublished.paginated_search(params))
  end
end
