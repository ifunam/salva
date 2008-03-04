class UserGenericworkController < MultiSalvaController
  def initialize
    super
    @model = UserGenericwork
    @views = [ :otherwork, :user_genericwork]
    @models = [UserGenericwork, Genericwork]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = {:joins => "INNER JOIN genericworkgroups ON genericworkgroups.name = 'Otro'  INNER JOIN genericworktypes ON genericworktypes.genericworkgroup_id = genericworkgroups.id INNER JOIN genericworks ON genericworks.id = user_genericworks.genericwork_id AND genericworks.genericworktype_id = genericworktypes.id"}
  end
end
