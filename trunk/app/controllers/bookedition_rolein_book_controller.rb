class BookeditionRoleinBookController < SalvaController
  def initialize
    super
    @model = BookeditionRoleinBook
    @create_msg = 'El BookeditionRoleinBook ha sido agregado'
    @update_msg = 'El BookeditionRoleinBook ha sido actualizado'
    @purge_msg = 'El BookeditionRoleinBook se ha ido borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
