class ChapterinbookRoleinbookController < SalvaController
  def initialize
    super
    @model = ChapterinbookRoleinbook
    @create_msg = 'El ChapterinbookRoleinbook ha sido agregado'
    @update_msg = 'El ChapterinbookRoleinbook ha sido actualizado'
    @purge_msg = 'El ChapterinbookRoleinbook se ha ido borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
