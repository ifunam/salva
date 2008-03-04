class UnpublishedArticleController < SalvaController
  def initialize
    super
    @model = Article
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @list = { :include => [:articlestatus], :conditions => "articlestatuses.name != 'Publicado' AND articles.articlestatus_id = articlestatuses.id", :order => 'articles.year DESC' }
  end
end
