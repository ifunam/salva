class UserInproceedingController < SalvaController
  def initialize
    super
    @model = UserGenericwork
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @list = {:joins => "INNER JOIN genericworks ON genericworks.genericworktype_id = 3 AND genericworks.id = user_genericworks.genericwork_id"}
  end
end
