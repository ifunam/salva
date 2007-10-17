class CityController < SalvaController
  def initialize
    super
    @model = City
    @create_msg = 'La ciudad ha sido agregada'
    @update_msg = 'La ciudad ha sido actualizada'
    @purge_msg = 'La ciudad ha sido borrada'
    @per_pages = 10
    @order_by = 'name'
  end
end
