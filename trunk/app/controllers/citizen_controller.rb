class CitizenController < SalvaController
  def initialize
    super
    @model = Citizen
    @create_msg = 'La nacionalidad ha sido agregada'
    @update_msg = 'La nacionalidad ha sido actualizada'
    @purge_msg = 'La nacionalidad se ha borrado'
    @per_pages = 10
    @order_by = 'citizen_country_id'
  end
end
