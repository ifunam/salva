class InstitutionController < SalvaController
  auto_complete_for :institution, :name
  def initialize
    super
    @model = Institution
    @create_msg = 'La instituciÃ³n ha sido agregdao'
    @update_msg = 'La instituciÃ³n ha sido actualizaao'
    @purge_msg = 'La instituciÃ³n se ha borrado'
    @per_pages = 10
    @order_by = 'institutiontitle_id, name, institutiontype_id, country_id'
  end
end
