class ThesisJurorsController < MultiSalvaController
  def initialize
    super
    @model = ThesisJuror
    @views = [ :published_thesis, :professional_career, :institution, :thesis_juror ]
    @models = [ ThesisJuror, [ Thesis, [Institutioncareer, Career, Institution] ] ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
