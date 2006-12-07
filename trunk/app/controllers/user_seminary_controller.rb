class UserSeminaryController < SalvaController
  def initialize
    super
    @model = UserSeminary
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:roleinseminary], :conditions => "roleinseminaries.name = 'Ponente' AND user_seminaries.roleinseminary_id = roleinseminaries.id " }
  end
end
