class UserconferencesController < MultiSalvaController
  def initialize
    super
    @model = Userconference
    @views = [ :conference, :userconference]
    @models = [Userconference, Conference]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:roleinconference], :conditions => "roleinconferences.name = 'Asistente'  AND userconferences.roleinconference_id = roleinconferences.id"}
  end
end
