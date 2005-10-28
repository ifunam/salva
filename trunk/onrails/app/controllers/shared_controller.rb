#  app/controllers/shared_controller
class SharedController < ApplicationController
  def index
    list
  end
  
  def list
    @list_pages, @list = paginate mymodel, :per_page => mymodel.per_pages, :order_by => mymodel.order_by
    render :action => 'list'
  end
 
  def edit
    @edit = mymodel.find(params[:id])
    render :action => 'edit'
  end
 
  def new
    @edit = mymodel.new
    render :action => 'new'
  end
 
  def create
    @edit = mymodel.new(params[:edit])
    if @edit.save
      flash[:notice] = mymodel.create_msg
      redirect_to :action => 'list'
    else
      render :action => 'list'
    end
  end
 
  def update
    @edit = mymodel.find(params[:id])
    if @edit.update_attributes(params[:edit])
      flash[:notice] = mymodel.update_msg
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    mymodel.find(params[:id]).destroy
     flash[:notice] = mymodel.destroy_msg
    redirect_to :action => 'list'
  end

  def purge_selected
    unless @params[:item].nil?
      @params[:item].each { |id, contents|
        if contents[:checked]
          mymodel.find(id).destroy
        end
      }
    end
    redirect_to :action => 'list'
  end
end
