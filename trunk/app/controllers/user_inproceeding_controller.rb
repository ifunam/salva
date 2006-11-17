class UserInproceedingController < SalvaController
  def initialize
    super
    @model = UserGenericwork
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @model_conditions = [ 'genericwork_id = ?', ['genericworktype_id != ?', 3] ]
  end
end
