class ArticleController < SalvaController
  def initialize
    super
    @model = Article
    @create_msg = 'El Article ha sido agregado'
    @update_msg = 'El Article ha sido actualizado'
    @purge_msg = 'El Article se ha ido a chingar a su madre'
    @per_pages = 10
    @order_by = 'title, year DESC'
  end
end
