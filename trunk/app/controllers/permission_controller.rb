class PermissionController < SalvaController
  def initialize
    super
    @model = Permission
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'controller_id, roleingroup_id, action_id ASC'
  end
end
