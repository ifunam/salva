class UserAdscriptionsController < SalvaController
  before_filter :check_for_requirements

  def initialize
    super
    @model = UserAdscription
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

  def check_for_requirements
    @jobposition = Jobposition.find(:first, :conditions => [ 'institutions.institution_id = 1 AND user_id = ?', session[:user]], :include => :institution) # Buscar jobpositions en la UNAM
    if !@jobposition
      flash[:notice] = 'Por favor registre una categoría antes de ingresar su adscripción...'
      model_into_stack(controller_name, 'new', nil, UserAdscription.new, 'jobposition_id')
      redirect_to :controller => 'jobposition_at_institution', :action => 'new'
    end
  end
end
