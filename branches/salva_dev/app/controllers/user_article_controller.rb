class UserArticleController < SalvaController
  def initialize
    super
    @model = UserArticle
    @create_msg = 'El UserArticle ha sido agregado'
    @update_msg = 'El UserArticle ha sido actualizado'
    @purge_msg = 'El UserArticle se ha ido a chingar a su madre'
    @per_pages = 10
    @order_by = 'article_id DESC'
  end
end
