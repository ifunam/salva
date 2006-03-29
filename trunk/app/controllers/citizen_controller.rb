class CitizenController < SalvaController
  def initialize
    super
    @model = Citizen
    @create_msg = 'El Citizen ha sido agregado'
    @update_msg = 'El Citizen ha sido actualizado'
    @purge_msg = 'El Citizen se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
