class AddressController < SalvaController
  def initialize
    super
    @model = Address
    @create_msg = 'La Address ha sido agregado'
    @update_msg = 'La Address ha sido actualizado'
    @purge_msg = 'La Address se ha borrado'
    @per_pages = 10
    @order_by = 'addresstype_id, addr'
  end
end
