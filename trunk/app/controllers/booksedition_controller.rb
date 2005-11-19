
class BookseditionController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  def list
    @booksedition_pages, @bookseditions = paginate :booksedition, :per_page => 10
  end

  def show
    @booksedition = Booksedition.find(params[:id])
  end

  def new
    @booksedition = Booksedition.new
  end

  def create
    @booksedition = Booksedition.new(params[:booksedition])
    if @booksedition.save
      flash[:notice] = 'Booksedition was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @booksedition = Booksedition.find(params[:id])
  end

  def update
    @booksedition = Booksedition.find(params[:id])
    if @booksedition.update_attributes(params[:booksedition])
      flash[:notice] = 'Booksedition was successfully updated.'
      redirect_to :action => 'show', :id => @booksedition
    else
      render :action => 'edit'
    end
  end

  def destroy
    Booksedition.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def publisher_select
     render_text select("booksedition", "publisher_id", Publisher.find_all.collect {|p| [ p.name, p.id ] })
  end
  
end
