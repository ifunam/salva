class UserThesesController < MultiSalvaController
  def initialize
    super
    @model = UserThesis
    @views = [ :thesis, :professional_career, :institution, :user_thesis]
    @models = [ UserThesis, [ Thesis, [Institutioncareer, Career, Institution] ] ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:roleinthesis], :conditions => "(roleintheses.name = 'Director' OR roleintheses.name = 'Asesor' OR roleintheses.name = 'Lector')  AND user_theses.roleinthesis_id = roleintheses.id" }  
  end
end
