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

  def create
    build_resource.user_id = current_user.id
    resource.registered_by_id = current_user.id
    super
  end

  def update
    resource.modified_by_id = current_user.id
    super
  end

  def destroy
    if resource.registered_by_id == current_user.id
      super
    end
  end

  def destroy_all
    if params[:ids] and params[:ids].is_a? Array
      collection = resource_class.find(params[:ids])
      collection.collect(&:destroy)
      respond_with(collection, :status => :deleted_records) do |format|
        format.js { render :text => 'deleted_records'}
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
                        .paginate(:page => params[:page] || 1,:per_page => params[:per_page] || 10)
  end
end