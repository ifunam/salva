class BookeditionCommentsController < SalvaController
  def initialize
    super
    @model = BookeditionComment
    @create_msg = 'El BookeditionComment ha sido agregado'
    @update_msg = 'El BookeditionComment ha sido actualizado'
    @purge_msg = 'El BookeditionComment se ha ido borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
