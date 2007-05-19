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

  def index
    @jobposition = Jobposition.find(:first, :conditions => [ 'institutions.institution_id = 1 AND user_id = ?', session[:user]], :include => :institution) # Buscar jobpositions en la UNAM
    if @jobposition != nil
      list
    else
      flash[:notice] = 'Por favor registre una categoría antes de ingresar su adscripción...'
      model_into_stack(UserAdscription.new, 'new', 'jobposition_id', controller_name)
      logger.info "stack_empty? "+ session[:stack].empty?.to_s
      redirect_to :controller => 'jobposition_at_institution', :action => 'new'
    end
  end

end
