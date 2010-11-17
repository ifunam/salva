class UserResourcesController < InheritedResources::Base
  layout 'user_resources'

  respond_to :html
  respond_to :js, :only => [:index]
  class_inheritable_accessor :resource_class_scope

  def self.defaults(options)
    if options.has_key? :resource_class_scope
      self.resource_class_scope =  options[:resource_class_scope]
      options.delete :resource_class_scope
    end
    super
  end

  def index
    params[:search] ||= {}
    params[:search].merge!(:user_id_eq => current_user.id)
    respond_with set_collection_ivar(scoped_resource_class.search(params[:search]).paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 10))
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

  protected
  def has_resource_class_scope?
    !self.resource_class_scope.nil?
  end

  def scoped_resource_class
    has_resource_class_scope? ? self.resource_class.send(self.resource_class_scope) : self.resource_class
  end
end