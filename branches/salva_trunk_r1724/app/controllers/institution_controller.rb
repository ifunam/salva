class InstitutionController < SalvaController
  auto_complete_for :institution, :name
  def initialize
    super
    @model = Institution
    @create_msg = 'La institución ha sido agregada'
    @update_msg = 'La institución ha sido actualizada'
    @purge_msg = 'La institución se ha borrado'
    @per_pages = 10
    @order_by = 'institutiontitle_id, name, institutiontype_id, country_id'
  end
end
