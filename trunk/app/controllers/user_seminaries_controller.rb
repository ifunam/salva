class UserSeminariesController < MultiSalvaController
  def initialize
    super
    @model = UserSeminary
    @views = [ :seminary, :institution, :user_seminary ]
    @models = [ UserSeminary, [Seminary, Institution] ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:roleinseminary], :conditions => "(roleinseminaries.name = 'Ponente' OR roleinseminaries.name = 'Organizador') AND user_seminaries.roleinseminary_id = roleinseminaries.id " }
  end
end
