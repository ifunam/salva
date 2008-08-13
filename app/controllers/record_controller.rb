class RecordController < ApplicationController
  def initialize
    @hash_name  = Inflector.tableize(@model).singularize.to_sym
    @columns = @model.column_names - %w(id user_id created_at updated_at moduser_id)
  end

  def show
    @record = @model.find(:first, :conditions => "#{Inflector.tableize(@model)}.user_id = #{session[:user]}")
    unless @record.nil?
      respond_to do |format|
        if request.xhr?
          format.html { render  :partial => 'record_controller/show'  }
        else
          format.html { render  :action => 'show'  }
        end
     end
    else
      if request.xhr?
        render :update do |page|
               page.hide 'form'
               page.redirect_to :action => 'new'
         end
      else
        redirect_to :action => :new
      end
    end
  end

  def new
    @record = @model.new
    respond_to do |format|
      if request.xhr?
        format.html { render  :action => 'new', :layout => false }
      else
        format.html { render  :action => 'new'  }
      end
    end
  end

  def create
    @record = @model.new(params[@hash_name])
    self.set_user(@record)
    self.set_quickposts(@record)
    respond_to do |format|
      if  @record.save
        format.js { render :partial => 'record_controller/create.rjs' }
      else
        format.js { render :partial => 'shared/errors.rjs' }
      end
    end
  end

  def edit
    @record = @model.find(:first, :conditions => ['user_id = ?', session[:user]])
    respond_to do |format|
      format.html { render :partial=> 'record_controller/edit', :layout => false }
    end
  end

  def update
    @record = @model.find(:first, :conditions => ['user_id = ?', session[:user]])
    self.set_user(@record)
    self.set_quickposts(@record)
    respond_to do |format|
      if  @record.update_attributes(params[@hash_name])
        format.js { render :partial => 'record_controller/update.rjs' }
      else
        format.js { render :partial => 'shared/errors.rjs' }
      end
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
