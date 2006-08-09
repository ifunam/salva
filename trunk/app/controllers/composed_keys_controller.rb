class ComposedKeysController < ApplicationController
  skip_before_filter :rbac_required
  model :model_composed_keys
  
  def index
    render :action => 'new'
  end
  
  def get_composed
    session[:composed] 
  end
  
  def new
    @edit = get_composed
  end
  
  def create
    @edit = get_composed
    @edit.prepare(params[:edit])
    if @edit.is_valid?
      @edit.save
      flash[:notice] = @create_msg
      redirect_to :controller => Inflector.underscore(@edit.model).downcase, :action => 'list'
      
    else
      logger.info "*** Algo esta mal <<wey>>, checalo! ***"
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'new'
    end
  end
  
  def edit
    @edit = get_composed

    @edit.model.find(:All, :conditions => [ 'where user_id'])
  end

  def update
    composed = get_composed
    composed.prepare(params[:edit])
    if composed.update
    else
    end
  end
  #  def list
  #  end

end
