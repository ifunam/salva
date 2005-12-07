#  app/controllers/shared_controller
class SalvaController < ApplicationController
  $debug = 1

  def initialize
    @sequence = nil
  end
  
  def index
    list
  end
  
  def list
    @pages, @collection = paginate @model, :per_page => @per_pages, :order_by =>  @order_by
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
    redirect_to :controller => model_other, :action => 'new', :lider_id => lider, :lider_name => Inflector.underscore(@model.name)
  end

  def new_sequence
    lider_id = params[:lider_id]
    lider_name =  params[:lider_name]
    sequence = ModelSequence.new(@sequence)
    sequence.moduser_id = @session[:user] if sequence.attribute_present?('moduser_id')
    sequence.user_id = @session[:user] if sequence.attribute_present?('user_id')
    logger.info "New sequence Lider "+lider_id.to_s if lider_id != nil
    sequence.set_lider(lider_id, lider_name) if lider_id != nil and lider_name != nil
    session[:sequence] = sequence
    redirect_to :controller => 'wizard', :action => 'new'
  end

  def create
    @edit = @model.new(params[:edit])
    @edit.moduser_id = @session[:user] if @edit.attribute_present?('moduser_id')
    @edit.user_id = @session[:user] if @edit.attribute_present?('user_id')
    if @edit.save
      flash[:notice] = @create_msg
      redirect_to :action => 'list'
    else
      logger.info "*** Algo esta mal <<wey>>, checalo! ***"
      logger.info @edit.errors.full_messages
      render :action => 'list'
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
    unless @params[:item].nil?
      @params[:item].each { |id, contents|
        if contents[:checked]
          @model.find(id).destroy
        end
      }
    end
    redirect_to :action => 'list'
 end
 
 def show
    @edit = @model.find(params[:id])
 end
 
end
