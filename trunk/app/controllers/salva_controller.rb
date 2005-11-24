#  app/controllers/shared_controller
class SalvaController < ApplicationController
  $debug = 0

  def initialize
    @sequence = nil
  end
  
  def index
    list
  end
  
  def list
    @pages, @list = paginate @model, :per_page => self.per_pages, :order_by =>  self.order_by
    render :action => 'list'
  end
  
  def edit
    @edit = @model.find(params[:id])
    render :action => 'edit'
  end
  
  def new
   if @sequence
     new_sequence
    else 
      @edit = @model.new
      render :action => 'new'
    end
  end

  def new_sequence
    lider = @model.new
    lider.moduser_id = @session[:user]
    models = [ lider ]
    @sequence.map{ |model| models << model.new }
    sequence = ModelSequence.new(models)
    sequence.lider_id = @model.table_name()+'_id';
    logger.info "Table "+sequence.lider_id if $debug
    session[:sequence] = sequence
    redirect_to :controller => 'wizard', :action => 'new'
  end

  def create
    @edit = @model.new(params[:edit])
    @edit.moduser_id = @session[:user]
    if @edit.save
      flash[:notice] = self.create_msg
      redirect_to :action => 'list'
    else
      render :action => 'list'
    end
  end
 
  def update
    @edit = @model.find(params[:id])
    if @edit.update_attributes(params[:edit])
      flash[:notice] = self.update_msg
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @model.find(params[:id]).destroy
     flash[:notice] = self.destroy_msg
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
end
