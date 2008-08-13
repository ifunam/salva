class UserConferencetalksController < MultiSalvaController
  def initialize
    @model = UserConferencetalk
    @views = [ :conferencetalk, :conference, :user_conferencetalk ]
    @models = [ UserConferencetalk, [Conferencetalk, Conference] ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
   super
 end
end
