class InstitutiontitleController < SalvaController
  def initialize
    super
    @model = Institutiontitle
    @create_msg = 'El título ha sido agregado'
    @update_msg = 'El título ha sido actualizado'
    @purge_msg = 'El título se ha borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
