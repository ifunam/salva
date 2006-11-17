class JobpositionExternalController < SalvaController
  def initialize
    super
    @model = Jobposition
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @model_conditions = [ 'institution_id = ?', ['institution_id != ?', 1] ]
  end
end
