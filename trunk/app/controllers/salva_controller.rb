#  app/controllers/shared_controller
require 'iconv'
require 'list'
require 'stackcontroller'
class SalvaController < ApplicationController
  include List
  include Stackcontroller
  
  def initialize
    @sequence = nil
  end
  
  def index
    list
  end
  
  def list # Maybe we will need a specific class to the *lists* handling

    conditions = set_conditions_from_search
    per_page = set_per_page
    
    @pages, @collection = paginate Inflector.pluralize(@model), 
    :per_page => per_page || @per_pages, :order_by => @order_by, 
    :conditions => conditions

    render :action => 'list'
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update ]
  
  def edit
    if @sequence != nil
      edit_sequence
    else
      @edit = is_this_model_in_stack? ? get_model_from_stack : @model.find(params[:id])
      render :action => 'edit'
    end
  end
  
  def new
    if @sequence != nil
      new_sequence
    else
      @edit = is_this_model_in_stack? ? get_model_from_stack : @model.new
      render :action => 'new'
    end
  end
  
  def create
    setinput_xmlhttprequest if request.xml_http_request?
    @edit = @model.new(params[:edit])
    set_userid
    set_model_into_stack(@edit,'new',@params[:stack]) and return true if @params[:stack] != nil
    if @edit.save
      flash[:notice] = @create_msg
      # set_handler_id_into_stack(@edit.id) if has_model_in_stack?
      redirect_to_controller(*get_options_to_redirect.to_a)
    else
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'new'
    end
  end
  
  def update
    @edit = @model.find(params[:id])
    set_userid
    set_model_into_stack(@edit,'edit',@params[:stack]) and return true if @params[:stack] != nil
    if @edit.update_attributes(params[:edit])
      flash[:notice] = @update_msg
      redirect_to_controller(*get_options_to_redirect.to_a)
    else
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'edit'
    end
  end
  
  def purge
    if @sequence
      sequence = ModelSequence.new(@sequence)
      sequence.moduser_id = session[:user] 
      sequence.user_id = session[:user] 
      sequence.fill(params[:id])
      logger.info "Sequencedel "+sequence.delete.to_s
    else
      @model.find(params[:id]).destroy
    end
    flash[:notice] = @purge_msg
    redirect_to :action => 'list'
  end

  def purge_selected
    if  params[:item]
      params[:item].each { |id, contents|
        @model.find(id).destroy
      }
    end
    redirect_to :action => 'list'
  end
 
  def show
    if @sequence
      sequence = ModelSequence.new(@sequence)
      sequence.moduser_id = session[:user] 
      sequence.user_id = session[:user] 
      sequence.fill(params[:id])
      session[:sequence] = sequence
      redirect_to :controller => 'wizard', :action => 'show'
    else
      @edit = @model.find(params[:id])
      render :action => 'show'
    end  
  end

  def cancel
    redirect_to_controller(*get_options_to_redirect.to_a)
  end

  private
  def new_sequence
    sequence = ModelSequence.new(@sequence)
    sequence.moduser_id = session[:user] 
    sequence.user_id = session[:user] 
    session[:sequence] = sequence
    redirect_to :controller => 'wizard', :action => 'new'
  end

  def edit_sequence
    sequence = ModelSequence.new(@sequence)
    sequence.moduser_id = session[:user] 
    sequence.user_id = session[:user] 
    sequence.fill(params[:id])
    session[:sequence] = sequence
    redirect_to :controller => 'wizard', :action => 'edit'
  end

  def setinput_xmlhttprequest
    params[:edit].each { |key, value|
      unless key.match(/\_id$/)
        params[:edit][key] = Iconv.new('iso-8859-15','utf-8').iconv(value) 
      end
    }
  end

  def get_options_to_redirect
    options = [ controller_name, 'list']
    if session[:stack] 
      options = get_controller_options_from_stack unless session[:stack].empty?
    end
    options
  end

  def set_userid
    @edit.moduser_id = session[:user] if @edit.has_attribute?('moduser_id')
    @edit.user_id = session[:user] if @edit.has_attribute?('user_id')
  end
  
#   def new_else
#     model_other = params[:model]
#     lider =  @model.find(params[:lider])
#     logger.info "New else Lider "+lider.to_s if lider != nil
#     redirect_to :controller => model_other, :action => 'new', 
#     :lider_id => lider, :lider_name => Inflector.undescore(@model.name)
#   end
  
end
