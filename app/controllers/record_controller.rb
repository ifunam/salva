class RecordController < ApplicationController
  def initialize
    @hash_name  = Inflector.tableize(@model).singularize.to_sym
    @columns = @model.column_names - %w(id user_id created_at updated_at moduser_id)
  end

  def index
    @record = @model.find_by_user_id(session[:user_id])
    respond_to do |format|
      unless @record.nil?
        format.html { render :action => 'show'  }
        format.js   { render :action => 'show.rjs'}
      else
        @record = @model.new
        format.html { render :action => 'new' }
        format.js { render :action => 'new.rjs' }
      end
    end
  end
  alias_method :show, :index 

  def new
    @record = @model.new
    respond_to do |format|
      format.html { render  :action => 'new'  }
      format.js { render  :action => 'new.rjs' }
    end
  end

  def create
    @record = @model.new(params[@hash_name])
    self.set_user(@record)
    self.set_quickposts(@record)
    respond_to do |format|
      if @record.save
        format.html { redirect_to :action => :index }
        format.js { render :action=> 'create.rjs' }
      else
        format.html { render :action => 'new'  }
        format.js { render :action => 'errors.rjs' }
      end
    end
  end

  def edit
    @record = @model.find_by_user_id(session[:user_id])
    respond_to do |format|
      format.html { render :action => 'edit' }
      format.js { render :action => 'edit.rjs' }
    end
  end

  def update
    @record = @model.find_by_user_id(session[:user_id])
    self.set_user(@record)
    self.set_quickposts(@record)
    respond_to do |format|
      if @record.update_attributes(params[@hash_name])
        format.html { redirect_to :action => :index }
        format.js { render :action => 'update.rjs' }
      else
        format.html { render :action => 'edit' }
        format.js { render :action => 'errors.rjs' }
      end
    end
  end

  def destroy
    @record = @model.find_by_user_id(session[:user_id])
    @record.destroy
    respond_to do |format|
      format.html { redirect_to :action => :index }
      format.js { render :action => 'destroy.rjs' }
    end
  end

  protected
  def set_quickposts(record)
    unless params[:quickposts].nil?
      params[:quickposts].keys.each do |k|
        m = Inflector.classify(k).constantize
        h = params[:quickposts][k]
        belongs_to_record = m.exists?(h) ? m.find(:first, :conditions => h) : m.new(h)
        record.send(k+'=', belongs_to_record)
        record.[]=(Inflector.foreign_key(m), nil)
      end
    end
  end
end
