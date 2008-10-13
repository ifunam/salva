class ModelMapperController < ApplicationController
  
  def initialize
    @model_mapper = ModelDependentMapper.new([])
  end
  
  def index
    @collection = UserArticle.paginate(:all, :conditions => ['user_id = ?', session[:user_id]])
    respond_to do |format|
      format.html { render :action => 'index'}
      format.js   { render :action => 'index.rjs'}
    end
  end

  def new
    respond_to do |format|
      format.html { render :partial => 'model_mapper/new'}
      format.js   { render :action => 'index.rjs'}
    end
  end

  def create
    @model_mapper.set_attributes(params)
    @model_mapper.set_user(session[:user_id])
    respond_to do |format|
      if @model_mapper.save
        format.html { render :partial => 'model_mapper/create'}
        format.js   { render :action => 'index.rjs'}
      else
        format.html { redirect_to :action => :new }
        format.js { responds_to_parent { render :action => 'errors.rjs' } }
        format.xml  { render :xml => @model_mapper.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end
end