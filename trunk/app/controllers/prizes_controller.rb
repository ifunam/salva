class PrizesController < MultiSalvaController
  def initialize
    super
    @model = Prize
    @views = [:prizetype, :prize, :institution]
    @models = [ Prize, Institution, Prizetype]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
