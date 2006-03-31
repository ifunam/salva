class CitizenmodalityController < SalvaController
  def initialize
    super
    @model = Citizenmodality
    @create_msg = 'La modalidad ha sido agregada'
    @update_msg = 'La modalidad ha sido actualizada'
    @purge_msg = 'La modalidad se ha borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
