require 'finder'
class SalvaController < ApplicationController
  def initialize
    @hash_name  = Inflector.tableize(@model).singularize.to_sym
    @columns = @model.column_names - %w(id moduser_id created_on updated_on user_id parent_id)
    @find_options = { }
   end

  def index
    set_user_condition if @model.column_names.include?('user_id')

    @collection = @model.paginate :page => params[:page] || 1, :per_page => 10 || param[:per_page],
    :conditions => @find_options[:conditions], :include => @find_options[:include], :joins => @find_options[:joins],
    :select => @find_options[:select], :order => @find_options[:order]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collection }
    end
  end

  def show
    @finder = Finder.new(@model, :first, :attributes => @columns,  :conditions => "#{Inflector.tableize(@model)}.id =  #{params[:id]}")
    @record = @finder.as_record
    respond_to do |format|
      format.html { render :partial => 'shared/show', :layout => false}
    end
  end

  def new
    @record = @model.new
    respond_to do |format|
      format.html { render :partial => 'shared/new', :layout => false }
      format.xml  { render :xml => @record }
    end
  end

  def edit
    @record = @model.find(params[:id])
    respond_to do |format|
      format.js { render :partial => 'shared/edit.rjs'}
     end
  end

  def create
    @record = @model.new(params[@hash_name])
    self.set_user(@record)
    respond_to do |format|
      if @record.save
        format.js { render :partial => 'shared/create.rjs'}
        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.js { render :partial => "shared/errors.rjs" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @record = @model.find(params[:id])
    respond_to do |format|
      if @record.update_attributes(params[@hash_name])
        format.js { render :partial => 'shared/update.rjs'}
        format.xml { head :ok }
      else
        format.js { render :partial => "shared/errors.rjs" }
        format.xml { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
 end

  def destroy
    @record = @model.find(params[:id])
    @record.destroy
    respond_to do |format|
      if request.xhr?
        format.js { render :partial => 'shared/destroy.rjs' }
      else
        format.html { redirect_to  :action => :index }
       end
    end
  end

  def destroy_all
    @collection = params[:id].collect { |id| @model.find(id) }
    respond_to do |format|
      format.js { render :partial => 'shared/destroy_id.rjs',  :collection => @collection }
    end
    @model.delete(@collection.collect {|record| record.id })
   end

  protected
  def set_user_condition
    user_condition = @model.table_name + '.user_id =  ' + session[:user].to_s
    if @find_options.has_key?(:joins)
      @find_options[:joins] += " AND #{user_condition}"
    elsif @find_options.has_key?(:conditions)
      @find_options[:conditions] += " AND #{user_condition}"
    else
      @find_options[:conditions] = user_condition
    end
  end
end
