class IdentificationController < SalvaController
  def initialize
    super
    @model = Identification
    @create_msg = 'La identificación ha sido agregada'
    @update_msg = 'La identificación ha sido actualizada'
    @purge_msg = 'La identificación se ha borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
