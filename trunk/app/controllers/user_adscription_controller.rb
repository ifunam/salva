class UserAdscriptionController < SalvaController
  def initialize
    super
    @model = UserAdscription
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

#   def index
#     @jobposition = Jobposition.find_first([ 'user_id = ?', session[:user]]) # Buscar jobpositions en la UNAM
#     if @jobposition != nil
#       list
#     else
#       flash[:notice] = 'Por favor registre una categoría antes de ingresar su adscripción...'
#       redirect_to :controller => 'jobposition_at_institution', :action => 'list'
#     end
#   end

end
