class AddressController < SalvaController
  def initialize
    super
    @model = Address
    @create_msg = 'La dirección se ha guardado'
    @update_msg = 'la dirección se ha actualizado'
    @purge_msg = 'La dirección ha sido borrada'
    @per_pages = 10
    @order_by = 'postaddress DESC'
  end
end
