class UserPublishedArticleController < SalvaController
  def initialize
    super
    @model = UserArticle
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    articlestatus_id = Articlestatus.find_by_name('Publicado').id
    @list =  { :select => 'user_articles.*,  articles.*', :conditions => " articles.articlestatus_id = #{articlestatus_id} AND user_articles.article_id = articles.id", :include => [:article], :order => 'articles.year DESC, articles.month DESC, articles.title ASC' }
  end
end
