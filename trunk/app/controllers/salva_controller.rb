#  app/controllers/shared_controller
#require 'iconv'
class SalvaController < ApplicationController
  $debug = 1

  def initialize
    @sequence = nil
  end
  
  def index
    list
  end
  
  def list
    conditions = set_conditions
    @pages, @collection = paginate Inflector.pluralize(@model), 
    :per_page => @per_pages, :order_by => @order_by, :conditions => conditions
    render :action => 'list'
  end
  
  def edit
    @edit = @model.find(params[:id])
    render :action => 'edit'
  end
  
  def new
    logger.info "New Lider "+@lider.to_s if @lider != nil
   if @sequence
     new_sequence
    else 
      @edit = @model.new
      render :action => 'new'
   end
  end
  
  def new_else
    model_other = params[:model]
    lider =  @model.find(params[:lider])
    logger.info "New else Lider "+lider.to_s if lider != nil
    redirect_to :controller => model_other, :action => 'new', 
    :lider_id => lider, :lider_name => Inflector.undescore(@model.name)
  end

  def create
    if @request.env['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest' then
      name ||= params[:edit][:name]  
      logger.info "nombre utf[" +name+"]"
      params[:edit][:name] = Iconv.new('iso-8859-15','utf-8').iconv(name)
    end
    @edit = @model.new(params[:edit])
    @edit.moduser_id = @session[:user] if @edit.has_attribute?('moduser_id')
    @edit.user_id = @session[:user] if @edit.has_attribute?('user_id')
    if @edit.save
      flash[:notice] = @create_msg
      redirect_to :action => 'list'
    else
      logger.info "*** Algo esta mal <<wey>>, checalo! ***"
      logger.info @edit.errors.full_messages
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'new'
    end
  end
 
  def update
    @edit = @model.find(params[:id])
    if @edit.update_attributes(params[:edit])
      flash[:notice] = @update_msg
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end
  
  def purge
    @model.find(params[:id]).destroy
    flash[:notice] = @purge_msg
    redirect_to :action => 'list'
  end

  def purge_selected
    if  @params[:item]
      @params[:item].each { |id, contents|
        @model.find(id).destroy
      }
    end
    redirect_to :action => 'list'
  end
 
  def show
    @edit = @model.find(params[:id])
  end

  private
  def new_sequence
    sequence = ModelSequence.new(@sequence)
    sequence.moduser_id = @session[:user] 
    sequence.user_id = @session[:user] 
    session[:sequence] = sequence
    redirect_to :controller => 'wizard', :action => 'new'
  end

  def set_conditions
    session_key = controller_name.to_s + "list_conditions"
    if @params[controller_name]
      @session[session_key] = sql_conditions(@params[controller_name])
    else 
      @session[session_key] unless !@session[session_key]
    end
  end
  
  def sql_conditions(params)
    conditions = [ nil ]
    keys = []
    params.each { |key, value|
      if value != nil and value.length > 0 
        if key.match(/_id$/) and value.is_a? Integer 
          keys << key + " = ?"
          conditions << value
        else
          keys << key + " LIKE ?"
          conditions << '%'+value+'%'
        end
      end
    }	
    conditions[0] = keys.join(' AND ')
    conditions
  end
end
