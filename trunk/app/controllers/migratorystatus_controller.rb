class MigratorystatusController < SalvaController
  def initialize
    super
    @model = Migratorystatus
    @create_msg = 'El Migratorystatus ha sido agregado'
    @update_msg = 'El Migratorystatus ha sido actualizado'
    @purge_msg = 'El Migratorystatus se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
