class ChapterinbookController < SalvaController
  def initialize
    super
    @model = Chapterinbook
    @create_msg = 'El Chapterinbook ha sido agregado'
    @update_msg = 'El Chapterinbook ha sido actualizado'
    @purge_msg = 'El Chapterinbook se ha ido borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
