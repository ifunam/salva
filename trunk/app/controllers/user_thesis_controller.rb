class UserThesisController < SalvaController
  def initialize
    super
    @model = UserThesis
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :conditions => "user_theses.roleinthesis_id != 1" }  
  end
end
