class InstitutiontitleController < SalvaController
  def initialize
    super
    @model = Institutiontitle
    @create_msg = 'El tÃ­tulo ha sido agregado'
    @update_msg = 'El tÃ­tulo ha sido actualizado'
    @purge_msg = 'El tÃ­tulo se ha borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
