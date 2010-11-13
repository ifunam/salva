class PublicationController < InheritedResources::Base
  layout 'publications'

  respond_to :html
  respond_to :js, :only => [:index, :not_mine, :author_list, :add_author, :del_author]

  # Overwritting defaults method 
  class_inheritable_accessor :user_role_class, :resource_class_scope

  def self.defaults(options)
    [:user_role_class, :resource_class_scope].each do |k|
      self.set_default(options, k)
    end
    super
  end  
  
  def self.set_default(options, key)
    if options.has_key? key
      self.send("#{key}=", options[key]) 
      options.delete key
    end
  end

  def index
    params[:search] ||= {}
    params[:search].merge!(:user_id_eq => current_user.id)
    respond_with set_collection_ivar(scoped_resource_class.paginated_search(params))
    
  end

  def not_mine
    params[:search] ||= {}
    params[:search].merge!(:user_id_not_eq => current_user.id)
    respond_with set_collection_ivar(scoped_resource_class.paginated_search(params))
  end

  def create
    build_resource.registered_by_id = current_user.id
    super
  end

  def update
    resource.modified_by_id = current_user.id
    super
  end
  
  def author_list
    respond_with(resource)
  end

  def add_author  
    resource_user_role.create(:user_id => current_user.id)
    respond_with(resource)
  end

  def del_author
    resource_user_role.where(:user_id => current_user.id).first.destroy
    respond_with(resource)
  end

  protected
  def resource_user_role
    resource.send(self.user_role_class) 
  end

  def has_resource_class_scope?
    !self.resource_class_scope.nil?
  end

  def scoped_resource_class
     has_resource_class_scope? ? self.resource_class.send(self.resource_class_scope) : self.resource_class
  end
end
