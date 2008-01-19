#  app/controllers/shared_controller
require 'iconv'
require 'list'
require 'stackcontroller'
require 'model_serialize'
class MultiSalvaController < ApplicationController
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

    @collection = @model.paginate :page => params[:page] || 1, :per_page => per_page,
    :conditions => @list[:conditions], :include => @list[:include], :joins => @list[:joins],
    :select => @list[:select], :order => @list[:order]

    @parent_controller = 'algo' if has_model_in_stack?
    session[:model_serialize] = nil
    render :action => 'list'
  end

  def edit
      session[:model_serialize] = nil unless params[:id].nil?
      @record = (session[:model_serialize].nil?) ? ModelSerialize.new(@models, params[:id]) : session[:model_serialize] 
      instance_models
      @filter = model_from_stack(:filter)
      render :template => 'multi_salva/edit'
  end

  def new
    @record = (session[:model_serialize].nil?) ? ModelSerialize.new(@models) : session[:model_serialize] 
    instance_models
    @filter = model_from_stack(:filter)
    render :template => 'multi_salva/new'
  end

  def create
    @record = ModelSerialize.new(@models)
    set_userid
    @record.fill(params)
    if params[:stack] != nil
      session[:model_serialize] = @record
      redirect_to options_for_next_controller(@edit, controller_name, 'new')
    elsif params[:stacklist] != nil
      redirect_to options_for_next_controller(@edit, controller_name, 'new', 'list')
    else
      if @record.valid?
        @record.save
        session[:model_serialize] = nil
        flash[:notice] = @created_msg
        redirect_to stack_return(@record.id)
      else
        flash[:notice] = 'Hay errores al guardar esta información'
        instance_models
        render :template => 'multi_salva/new'
      end
    end
  end

  def update
    @record = ModelSerialize.new(@models, params[:id])
    set_userid
    @record.fill(params)
    if params[:stack] != nil
      session[:model_serialize] = @record
      redirect_to options_for_next_controller(@edit, controller_name, 'edit')
    elsif params[:stacklist] != nil
      redirect_to options_for_next_controller(@edit, controller_name, 'edit', 'list')
    else
      if @record.valid?
        @record.update_models
        session[:model_serialize] = nil
        if @children != nil and !has_model_in_stack?
          redirect_to :action => 'show', :id => @record.id
        else
          flash[:notice] = @update_msg
          redirect_to stack_return(@record.id)
        end
      else
        flash[:notice] = 'Hay errores al guardar esta información'
        instance_models
        render :template => 'multi_salva/edit'
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
      @record = ModelSerialize.new(@models, params[:id])
      instance_models
      model_into_stack(controller_name,  'show', @record.id)
      render :template => 'multi_salva/show'
  end

  def cancel
    redirect_to :action => 'list'
  end

  def back
    redirect_to (stack_back)
  end

  private

  def set_userid
    @record.moduser_id = session[:user]
    @record.user_id = session[:user]
  end

  def instance_models
    @record.records.keys.each { |k| eval "@#{k} = @record.records[k]" }
  end
end
