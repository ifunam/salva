 class AddressesController < ApplicationController
  # GET /addresses
  # GET /addresses.xml
  def initialize
    @model  = Address
    @created_msg = 'Address was successfully created.'
    @updated_msg = 'Address was successfully updated.'
    @hash_name   = Inflector.tableize(@model).singularize.to_sym
   end

  def index
    @collection = @model.paginate(:conditions => ['user_id = ?', session[:user]], :order => "addresstype_id ASC", :page => 1)
    respond_to do |format|
      format.html # index.html.erb
     format.xml  { render :xml => @collection }
    end
  end

  # GET /addresses/1
  # GET /addresses/1.xml
  def show
    @record = @model.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @record}
    end
  end

  # GET /addresses/new
  # GET /addresses/new.xml
  def new
    @record = @model.new

    respond_to do |format|
      format.html { render :action => 'new', :layout => false }
      format.xml  { render :xml => @record }
    end
  end

  # GET /addresses/1/edit
  def edit
    @record = @model.find(params[:id])
  end

  # POST /addresses
  # POST /addresses.xml
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

  # PUT /addresses/1
  # PUT /addresses/1.xml
  def update
    @record = @model.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[@hash_name])

        flash[:notice] = @update_msg
        format.html { redirect_to(@record) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.xml
  def destroy
    @record = @model.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html {redirect_to :action => :index}
      format.xml  { head :ok }
    end
  end

end
