class AddressController < SalvaController
  def initialize
    super
    @model = Address
    @create_msg = 'El Address ha sido agregado'
    @update_msg = 'El Address ha sido actualizado'
    @purge_msg = 'El Address se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
