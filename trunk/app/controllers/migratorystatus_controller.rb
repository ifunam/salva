class MigratorystatusController < SalvaController
  def initialize
    super
    @model = Migratorystatus
    @create_msg = 'El estado migratorio ha sido agregado'
    @update_msg = 'El estado migratorio ha sido actualizado'
    @purge_msg = 'El estado migratorio se ha borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
