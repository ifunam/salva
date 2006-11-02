class ResearchlineController < SalvaController
  auto_complete_for :researchline, :name
  def initialize
    super
    @model = Researchline
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
