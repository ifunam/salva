class UserUnpublishedArticleController < SalvaController
  def initialize
    super
    @model = UserArticle
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @list =  { :select => 'user_articles.*,  articles.*', :joins => "INNER JOIN articlestatuses ON articlestatuses.name != 'Publicado'  INNER JOIN articles ON articles.articlestatus_id = articlestatuses.id AND user_articles.article_id = articles.id", :order => 'articles.year DESC' }
  end
end
