class UserInproceedingController < SalvaController
  def initialize
    super
    @model = UserGenericwork
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list_include = :genericwork
    @list_conditions = "genericworks.genericworktype_id = 3 AND user_genericworks.genericwork_id = genericworks.id"
  end
end
