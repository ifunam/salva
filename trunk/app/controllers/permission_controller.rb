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

  def index
    @is_composed_keys  = Permission.is_composed_keys?
    @primary_keys = Permission.primary_keys
    params = { :edit => { :controller_id => 1, :roleingroup_id => 1, :action_id => [1,2,3,4,5,6,7,8,9]}}
    perm = Permission.new(params[:edit])
    @edit = perm.save
  end
  
end
