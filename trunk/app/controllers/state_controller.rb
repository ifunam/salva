class StateController < SalvaController
  def initialize
    super
    @model = State
    @create_msg = 'El State ha sido agregado'
    @update_msg = 'El State ha sido actualizado'
    @purge_msg = 'El State se ha ido borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
