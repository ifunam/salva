class StatesController < SalvaController
  def initialize
    super
    @model = State
    @create_msg = 'El estado ha sido agregado'
    @update_msg = 'El estado ha sido actualizado'
    @purge_msg = 'El estado se ha ido borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
