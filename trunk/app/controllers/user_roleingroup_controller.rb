class UserRoleingroupController < ComposedKeysController
  def initialize
    super
    @model = UserRoleingroup
    @composed_keys = %w( user_id )
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
  
  def set_userid
    @edit.moduser_id = session[:user] if @edit.has_attribute?('moduser_id')
  end
end
