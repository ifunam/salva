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
    @pages, @collection = paginate Inflector.pluralize(@model), :per_page => @per_pages, :order_by =>  @order_by
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
    redirect_to :controller => model_other, :action => 'new', :lider_id => lider, :lider_name => Inflector.undescore(@model.name)
  end

  def new_sequence
#    lider_id = params[:lider_id]
#    lider_name =  params[:lider_name]
    sequence = ModelSequence.new(@sequence)
    sequence.moduser_id = @session[:user] 
    sequence.user_id = @session[:user] 
    #   logger.info "New sequence Lider "+lider_id.to_s if lider_id != nilmo
#    sequence.set_lider(lider_id, lider_name) if lider_id != nil and lider_name != nil
    session[:sequence] = sequence
    redirect_to :controller => 'wizard', :action => 'new'
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
end
