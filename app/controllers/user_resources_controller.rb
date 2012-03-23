class UserResourcesController < InheritedResources::Base
  layout 'user_resources'

  respond_to :html
  respond_to :js, :only => [:index, :destroy_all]

  class_attribute :resource_class_scope

  def index
    params[:search] ||= {}
    params[:search].merge!(:user_id_eq => current_user.id)
    respond_with scoped_and_paginated_collection
  end

  def new
    build_resource
    resource_default_year
    super
  end

  def create
    build_resource.user_id = current_user.id
    resource.registered_by_id = current_user.id
    create! { collection_url }
  end

  def update
    resource.user_id = current_user.id
    resource.modified_by_id = current_user.id
    update! { collection_url }
  end

  def show
    authorize_action!
    super
  end

  def edit
    authorize_action!
    super
  end

  def destroy
    authorize_action!
    super
  end

  def destroy_all
    if params[:ids] and params[:ids].is_a? Array
      respond_with(destroy_all_selected_records!, :status => :deleted_records) do |format|
        format.js { render :nothing => true }
      end
    end
  end

  private
  def self.defaults(options)
    if options.has_key? :resource_class_scope
      self.resource_class_scope =  options[:resource_class_scope]
      options.delete :resource_class_scope
    end
    super
  end

  protected
  def has_resource_class_scope?
    !self.resource_class_scope.nil?
  end

  def scoped_resource_class
    has_resource_class_scope? ? self.resource_class.send(self.resource_class_scope) : self.resource_class
  end

  def scoped_and_paginated_collection
    set_collection_ivar scoped_resource_class.search(params[:search])
                        .page(params[:page] || 1).per(params[:per_page] || 10)
  end

  def resource_default_year
    %w(year startyear endyear).each do |attr|
      if resource.attribute_names.include? attr
        resource.send("#{attr}=", Documenttype.year_for_annual_report)
      end
    end
  end

  def authorize_action!
    unless resource.user_id == current_user.id
      authorize! :delete, resource.class.name, :message => "Unable to perform this action."
    end
  end

  def destroy_all_selected_records!
    resource_class.find(params[:ids].to_a).collect { |record|
      if record.user_id == current_user.id
        record.destroy
        nil
      else
        record
      end
    }.compact
  end
end