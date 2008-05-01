class StudentThesesController < MultiSalvaController
  def initialize
    super
    @model = UserThesis
    @views = [ :thesis, :student_thesis, :professional_career, :institution ]
    @models = [ UserThesis, [ Thesis, [ Institutioncareer, Career, Institution] ] ]

    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :conditions => "user_theses.roleinthesis_id = 1" }
  end
end
