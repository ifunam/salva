class SecretquestionController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @secretquestion_pages, @secretquestions = paginate :secretquestion, :per_page => 10, :order_by => 'name'
  end

  def show
    @secretquestion = Secretquestion.find(params[:id])
  end

  def new
    @secretquestion = Secretquestion.new
  end

  def create
    @secretquestion = Secretquestion.new(params[:secretquestion])
    if @secretquestion.save
      flash[:notice] = 'La nueva pregunta se ha guardado.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @secretquestion = Secretquestion.find(params[:id])

  end

  def update
    @secretquestion = Secretquestion.find(params[:id])
    if @secretquestion.update_attributes(params[:secretquestion])
      flash[:notice] = 'La pregunta ha sido actualizada.'
      redirect_to :action => 'show', :id => @secretquestion
    else
      render :action => 'edit'
    end
  end

  def destroy
    Secretquestion.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def purge_selected
    unless @params[:item].nil?
      @params[:item].each { |id, contents|
        if contents[:checked]
          Secretquestion.find(id).destroy
        end
      }
   end
    redirect_to :action => 'list'
  end
end
