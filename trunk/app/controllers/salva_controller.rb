#  app/controllers/shared_controller
require 'iconv'
require 'list'
require 'stackcontroller'
class SalvaController < ApplicationController
  include List
  include Stackcontroller

  def initialize

    # Default variables for the list method
    @list = {}
  end

  def index
    list
  end

  def list
    select = '*'
    if @model.column_names.include?('user_id')
      if @list.has_key?(:joins)
        @list[:joins] += " AND #{@model.table_name}.user_id = #{session[:user]}"
        select = Inflector.tableize(@model)+".*"
      elsif @list.has_key?(:conditions)
        @list[:conditions] += " AND #{@model.table_name}.user_id = #{session[:user]}"
      else
        @list[:conditions] = "#{@model.table_name}.user_id = #{session[:user]}"
      end
    end
    @list[:conditions] = set_conditions_from_search if params[controller_name]

    per_page = set_per_page

    @collection = @model.paginate :page => 1, :per_page => @per_pages,
    :conditions => @list[:conditions], :include => @list[:include], :joins => @list[:joins],
    :select => select

    @parent_controller = 'algo' if has_model_in_stack?
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update ]

  def edit
      @edit = model_from_stack || @model.find(params[:id])
      @filter = model_from_stack(:filter)
  end

  def new
      @edit = model_from_stack || @model.new
      @filter = model_from_stack(:filter)
  end

  def create
    @edit = @model.new(params[:edit])
    set_userid
    if params[:stack] != nil
      redirect_to options_for_next_controller(@edit, controller_name, 'new')
    elsif params[:stacklist] != nil
      redirect_to options_for_next_controller(@edit, controller_name, 'new', 'list')
    else
      if @edit.save
        if @children != nil
          redirect_to :action => 'show', :id => @edit.id
        else
          flash[:notice] = @create_msg
          redirect_to stack_return(@edit.id)
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
      redirect_to options_for_next_controller(@edit, controller_name, 'edit')
    elsif params[:stacklist] != nil
      redirect_to options_for_next_controller(@edit, controller_name, 'edit', 'list')
    else
      if @edit.update_attributes(params[:edit])
        if @children != nil
          redirect_to :action => 'show', :id => @edit.id
        else
          flash[:notice] = @update_msg
          redirect_to stack_return(@edit.id)
        end
      else
        flash[:notice] = 'Hay errores al guardar esta información'
        render :action => 'edit'
      end
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

  def select
    idx = nil
    if  params[:item]
      params[:item].each { |id, contents|
        idx = id
      }
    end
    logger.info "Radioparams "+idx.to_s+" "+params[:item].to_s
    redirect_to stack_select(idx)
  end

  def show
      @edit = @model.find(params[:id])
      model_into_stack(controller_name,  'show', @edit.id)
  end

  def cancel
    redirect_to (stack_cancel)
  end

  def back
    redirect_to (stack_back)
  end

  private

  def set_userid
    @edit.moduser_id = session[:user] if @edit.has_attribute?('moduser_id')
    @edit.user_id = session[:user] if @edit.has_attribute?('user_id')
  end

end
