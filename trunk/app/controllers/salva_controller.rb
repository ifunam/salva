#  app/controllers/shared_controller
require 'iconv'
require 'list'
require 'stackcontroller'
class SalvaController < ApplicationController
  include List
  include Stackcontroller
  
  def initialize
    @sequence = nil

    # Default variables for the list method
    @list = {}
  end
  
  def index
    list
  end
  
  def list
    if @model.column_names.include?('user_id')
      if @list.has_key?(:joins)
        @list[:joins] += " AND #{@model.table_name}.user_id = #{session[:user]}"
      elsif @list.has_key?(:conditions)
        @list[:conditions] += " AND #{@model.table_name}.user_id = #{session[:user]}" 
      else
        @list[:conditions] = "#{@model.table_name}.user_id = #{session[:user]}" 
      end
    end
    @list[:conditions] = set_conditions_from_search if params[controller_name]
    
    per_page = set_per_page

    @pages, @collection = paginate Inflector.pluralize(@model), 
    :conditions => @list[:conditions], :include => @list[:include], :joins => @list[:joins],
    :per_page => per_page || @per_pages

    render :action => 'list'
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update ]
  
  def edit
    if @sequence != nil
      edit_sequence
    else
      @edit = model_from_stack || @model.find(params[:id])
      render :action => 'edit'
    end
  end
  
  def new
    if @sequence != nil
      new_sequence
    else
      @edit = model_from_stack || @model.new
      render :action => 'new'
    end
  end
  
  def create
    @edit = @model.new(params[:edit])
    set_userid
    if params[:stack] != nil
      redirect_to options_for_next_controller(@edit, controller_name, 'new', params[:edit], params[:stack]) 
    else
      if @edit.save
        if @parent != nil
          redirect_to :controller => @parent, :action => 'show', :id => @edit.send(@parent) 
        elsif @children != nil
        redirect_to :action => 'show', :id => @edit.id 
        else
          flash[:notice] = @create_msg
          save_stack_attribute(@edit.id) if has_model_in_stack?
          redirect_to (options_for_return_controller)
        end
      else
      flash[:notice] = 'Hay errores al guardar esta información'
        render :action => 'new'
      end
    end
  end
  
  def update
    @edit = @model.find(params[:id])
    set_userid
    if params[:stack] != nil
      redirect_to options_for_next_controller(@edit, controller_name, 'new', params[:edit], params[:stack]) 
    else
      if @edit.update_attributes(params[:edit])
        if @parent != nil
          redirect_to :controller => @parent, :action => 'show', :id => @edit.send(@parent) 
        elsif @children != nil
          redirect_to :action => 'show', :id => @edit.id 
        else
        flash[:notice] = @update_msg
          save_stack_attribute(@edit.id) if has_model_in_stack?
          redirect_to (options_for_return_controller)
        end
      else
        flash[:notice] = 'Hay errores al guardar esta información'
        render :action => 'edit'
      end
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
      model_into_stack(@edit,  'show', 'id', controller_name)
      render :action => 'show'
    end  
  end

  def cancel
    redirect_to (options_to_redirect)
  end

  def back
    redirect_to (stack_back)
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
