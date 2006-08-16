class ComposedKeysController < SalvaController
  model :model_composed_keys
  
  def list
    @parent_controller = set_parent_controller
    conditions = set_conditions
    per_page = set_per_page
    model = set_model_in_session(@model,@composed_keys)
    @pages = Paginator.new self, @model.count, 10, per_page
    @collection = model.list      
    render :action => 'list'
  end  
  
  def new
    @edit = get_model
    render :action => 'new'
  end
  
  def create
    @edit = get_model
    @edit.prepare(params[:edit])
    if @edit.save
      flash[:notice] = @create_msg
      redirect_to :action => 'list'
    else
      logger.info "*** Algo esta mal <<wey>>, checalo! ***"
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'new'
    end
  end
  
  def show
    model = get_model
    @edit = model.find(params[:id])
    render :action => 'show'
  end
  
  def edit
    model = get_model
    @edit = model.find(params[:id])
    render :action => 'edit'
  end
  
  def update
    @edit = get_model
    @edit.update(params[:edit])
    
#    if @edit.is_valid?
#      @edit.update
#      flash[:notice] = @create_msg
      redirect_to :action => 'list'
#    else
#      logger.info "*** Algo esta mal <<wey>>, checalo! ***"
#      flash[:notice] = 'Hay errores al guardar esta información'
#      render :action => 'new'
    #    end
  end

  def purge
    model = get_model
    @edit = model.find(params[:id])
    @edit.destroy
    redirect :action => 'list'
  end

  private
  def set_model_in_session(model, keys)
    model = ModelComposedKeys.new(model, keys)    
    model.moduser_id = session[:user] 
    session[:composedkeys] = model
  end
  
  def get_model
    session[:composedkeys]
  end

end
