class BookeditionRoleinbookController < SalvaController
  def initialize
    @model = BookeditionRoleinbook
    @create_msg = 'El BookeditionRoleinbook ha sido agregado'
    @update_msg = 'El BookeditionRoleinbook ha sido actualizado'
    @purge_msg = 'El BookeditionRoleinbook se ha ido borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
