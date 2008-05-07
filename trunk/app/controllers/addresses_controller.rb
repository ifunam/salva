require 'finder'
class AddressesController < ApplicationController
  def initialize
    @model  = Address
    @created_msg = 'Address was successfully created.'
    @updated_msg = 'Address was successfully updated.'
    @hash_name   = Inflector.tableize(@model).singularize.to_sym
    # @columns = @model.column_names - %w(id moduser_id created_on updated_on user_id parent_id)
    @columns = %w(addresstype location pobox country state city zipcode phone movil other)
   end

  def index
    @collection = @model.paginate(:conditions => ['user_id = ?', session[:user]], :order => "addresstype_id ASC", :page => 1)
    respond_to do |format|
      format.html # index.html.erb
     format.xml  { render :xml => @collection }
    end
  end

  def show
    @finder = Finder.new(@model, :first, :attributes => @columns,  :conditions => "#{Inflector.tableize(@model)}.id =  #{params[:id]}")
    respond_to do |format|
      format.html { render :action => 'show', :layout => false}
    end
  end

  def new
    @record = @model.new
    respond_to do |format|
      format.html { render :action => 'new', :layout => false }
      format.xml  { render :xml => @record }
    end
  end

  def edit
    @record = @model.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'edit', :layout => false }
      format.js { render :action => 'edit.rjs'}
     end
  end

  def create
    @record = @model.new(params[@hash_name])
    self.set_user(@record)
    respond_to do |format|
      if @record.save
        flash[:notice] = @created_msg
        format.js { render :action => 'create.rjs'}
        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.js { render :action => "errors.rjs" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @record = @model.find(params[:id])
    respond_to do |format|
      if @record.update_attributes(params[@hash_name])
        format.js { render :action => 'edit.rjs'}
        format.xml { head :ok }
      else
        format.js { render :action => "errors.rjs" }
        format.xml { render :xml => @citizen.errors, :status => :unprocessable_entity }
      end
    end
 end

  def destroy
    @model.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to(addresses_url) }
      format.js { render :action => 'destroy.rjs' }
    end
  end
end
