class PeopleidController < SalvaController
  def initialize
    super
    @model = Peopleid
    @create_msg = 'La identificación ha sido agregada'
    @update_msg = 'La identificación ha sido actualizada'
    @purge_msg = 'La identificación se ha borrada'
    @per_pages = 10
    @order_by = 'descr'
  end
end
