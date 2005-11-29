
class BookeditionController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  def list
    @bookedition_pages, @bookeditions = paginate :bookedition, :per_page => 10
  end

  def show
    @bookedition = Bookedition.find(params[:id])
  end

  def new
    @bookedition = Bookedition.new
  end

  def create
    @bookedition = Bookedition.new(params[:bookedition])
    if @bookedition.save
      flash[:notice] = 'Bookedition was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @bookedition = Bookedition.find(params[:id])
  end

  def update
    @bookedition = Bookedition.find(params[:id])
    if @bookedition.update_attributes(params[:bookedition])
      flash[:notice] = 'Bookedition was successfully updated.'
      redirect_to :action => 'show', :id => @bookedition
    else
      render :action => 'edit'
    end
  end

  def destroy
    Bookedition.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def publisher_select
     render_text select("bookedition", "publisher_id", Publisher.find_all.collect {|p| [ p.name, p.id ] })
  end
  
end
