class PeopleidController < SalvaController
  def initialize
    super
    @model = Peopleid
    @create_msg = 'La identificaciÃ³n ha sido agregdao'
    @update_msg = 'La identificaciÃ³n ha sido actualizaao'
    @purge_msg = 'La identificaciÃ³n se ha borrado'
    @per_pages = 10
    @order_by = 'identification_id, descr, citizen_country_id'
  end
end
