class TeachingProductController < SalvaController
  def initialize
    super
    @model = Genericwork
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'  
    @list = { :include => [:genericworktype], :conditions => 'genericworktypes.genericworkgroup_id = 4 AND genericworks.genericworktype_id = genericworktypes.id' }
  end
end
