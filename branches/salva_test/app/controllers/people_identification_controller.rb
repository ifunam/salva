class PeopleIdentificationController < SalvaController
  def initialize
    super
    @model = PeopleIdentification
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

  def index
    @citizen = Citizen.find(:first, :conditions => [ 'user_id = ?', session[:user]])
    if @citizen
      list
    else
      flash[:notice] = 'Por favor registre su nacionalidad antes de ingresar alguna de sus identificaciones (RFC, CURP, etc)...'
      model_into_stack(controller_name, 'new', nil, PeopleIdentification.new, 'citizen_id') 
      redirect_to :controller => 'citizen', :action => 'new'
    end
  end
end
