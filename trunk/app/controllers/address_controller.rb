class AddressController < SalvaController
  def initialize
    super
    @model = Address
    @create_msg = 'La dirección ha sido agregada'
    @update_msg = 'La dirección ha sido actualizada'
    @purge_msg = 'La dirección se ha borrada'
    @per_pages = 10
    @order_by = 'addresstype_id, addr'
  end
end
