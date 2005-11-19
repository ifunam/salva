class BookController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @book_pages, @books = paginate :book, :per_page => 10 
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    book = Book.new
    book.moduser_id = @session[:user]
    sequence = ModelSequence.new([ book, Booksedition.new ])
    sequence.lider_id = Book.table_name()+'_id';
    logger.info "Table "+sequence.lider_id
    session[:sequence] = sequence
    redirect_to :controller => 'wizard', :action => 'new'
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:notice] = 'Book was successfully created.'
      redirect_to :controller => 'booksedition', :action => 'new', :book_id => @book
    else
      render :action => 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      flash[:notice] = 'Book was successfully updated.'
      redirect_to :action => 'show', :id => @book
    else
      render :action => 'edit'
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def list_selected
    unless @params[:item].nil?
      @books = []
      @params[:item].each { |id, contents|
        if contents[:checked]
          @books << Book.find(id)
        end
      }
    end
  end

end
