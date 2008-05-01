class ChapterinbookCommentsController < SalvaController
  def initialize
    super
    @model = ChapterinbookComment
    @create_msg = 'El ChapterinbookComment ha sido agregado'
    @update_msg = 'El ChapterinbookComment ha sido actualizado'
    @purge_msg = 'El ChapterinbookComment se ha ido borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
