#  app/controllers/shared_controller
require 'iconv'
class SalvaController < ApplicationController
  $debug = 1

  def initialize
    @sequence = nil
  end
  
  def index
    list
  end
  
  def list
    @parent_controller = set_parent_controller
    conditions = set_conditions
    per_page = set_per_page
    
    @pages, @collection = paginate Inflector.pluralize(@model), 
    :per_page => per_page || @per_pages, :order_by => @order_by, 
    :conditions => conditions

    render :action => 'list'
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update, 
                                      :return_to_parent_controller ],
  :redirect_to => { :action => :list }

  def return_to_parent_controller
    parent = session[:stack].pop
    set_child_params(parent[:child_key], params[:edit][:id]) 
    redirect_to :controller => parent[:name], :action => parent[:action],
                :id => parent[:id]
  end
  
  def edit
    @edit = @model.find(params[:id])
    @edit.attributes_before_type_cast.each { |attr,value|
      logger.info('edit_attr '+attr.to_s+' '+ value.class.name.to_s+' '+value.to_s)
    }
    render :action => 'edit'
  end
  
  def new
    logger.info "New Lider "+@lider.to_s if @lider != nil
   if @sequence
     new_sequence
   elsif @composed_keys 
     new_composed_keys
   else
     @edit = @model.new
     render :action => 'new'
   end
  end
  
  def new_else
    model_other = params[:model]
    lider =  @model.find(params[:lider])
    logger.info "New else Lider "+lider.to_s if lider != nil
    redirect_to :controller => model_other, :action => 'new', 
    :lider_id => lider, :lider_name => Inflector.undescore(@model.name)
  end

  def create
    setinput_xmlhttprequest if request.xml_http_request?
    @edit = @model.new(params[:edit])
    set_userid
    if @edit.save
      flash[:notice] = @create_msg
      redirect_to :action => 'list'
    else
      logger.info "*** Algo esta mal <<wey>>, checalo! ***"
      logger.info @edit.errors.full_messages
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'new'
    end
  end
 
  def update
    @edit = @model.find(params[:id])
    set_userid
    if @edit.update_attributes(params[:edit])
      flash[:notice] = @update_msg
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end
  
  def purge
    @model.find(params[:id]).destroy
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
    @edit = @model.find(params[:id])
  end

  private
  def new_sequence
    sequence = ModelSequence.new(@sequence)
    sequence.moduser_id = session[:user] 
    sequence.user_id = session[:user] 
    session[:sequence] = sequence
    redirect_to :controller => 'wizard', :action => 'new'
  end

  def new_composed_keys
    composed = ModelComposedKeys.new(@model, @composed_keys)
    composed.moduser_id = session[:user] 
    composed.user_id = session[:user] 
    session[:composed] = composed
    redirect_to :controller => 'composed_keys', :action => 'new'
  end

  def set_conditions
    session_key = controller_name.to_s + "_list_conditions"
    if params[controller_name]
      session[session_key] = sql_conditions(params[controller_name])
    else 
      session[session_key] unless !session[session_key]
    end
  end
  
  def sql_conditions(params)
    conditions = [ nil ]
    keys = []
    params.each { |key, value|
      if value != nil and value.length > 0 
        if key.match(/_id$/) 
          keys << key + " = ?"
          conditions << value
        else
          keys << key + " LIKE ?"
          conditions << '%'+value+'%'
        end
      end
    }	
    conditions[0] = keys.join(' AND ')
    conditions
  end

  def set_per_page
    session_key = controller_name.to_s + "_per_page"
    if params[:per_page] 
      session[session_key] = params[:per_page].to_i
    else
      session[session_key] unless !session[session_key] 
    end
  end

  def setinput_xmlhttprequest
    params[:edit].each { |key, value|
      unless key.match(/\_id$/)
        params[:edit][key] = Iconv.new('iso-8859-15','utf-8').iconv(value) 
      end
    }
  end

  def set_userid
    @edit.moduser_id = session[:user] if @edit.has_attribute?('moduser_id')
    @edit.user_id = session[:user] if @edit.has_attribute?('user_id')
  end
  
  def set_parent_controller
    if params[:parent] and params[:parent_action] and params[:key]
      session[:stack] = Stack.new() unless session[:stack] 
      args = set_stack_params(params)
      session[:stack].push(args)
    end
    session[:stack].has_items? if session[:stack]
  end

  def set_stack_params(args)
    { :name => args[:parent], :action => args[:parent_action],
      :child_key =>  args[:key], :id => args[:id]
    }
  end

  def set_child_params(child_key, id)
    session[:child] = { :name => child_key, :value => id }
  end
end
