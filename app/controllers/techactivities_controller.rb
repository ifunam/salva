class TechactivitiesController < SalvaController
  def initialize
    super
    @model = Activity
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'  
    @list = { :include => [:activitytype], :conditions => 'activitytypes.activitygroup_id = 7' }
  end
end
