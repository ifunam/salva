class SchoolingController < MultiSalvaController
  def initialize
    super
    @model = Schooling
    @views = [ :career,  :institution, :schooling ]
    @models = [ Schooling, [ Institutioncareer, Career, Institution]]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
