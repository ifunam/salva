class PublicationController < InheritedResources::Base
  layout 'publications'

  respond_to :html
  respond_to :js, :only => [:index, :not_mine, :user_list, :add_user, :del_user, :role_list]

  # Overwritting defaults method 
  class_attribute :user_role_class, :resource_class_scope, :role_class, :user_role_columns

  def self.defaults(options)
    [:user_role_class, :resource_class_scope, :role_class, :user_role_columns].each do |k|
      self.set_default(options, k)
    end
    self.role_list_method unless self.role_class.nil?
    super
  end

  def self.set_default(options, key)
    if options.has_key? key
      self.send("#{key}=", options[key]) 
      options.delete key
    end
  end

  def self.role_list_method
    define_method :role_list do
      resource
      respond_with(instance_variable_set("@#{self.role_class.to_s.pluralize}", self.role_class.to_s.classify.constantize.all))
    end
  end

  def index
    params[:search] ||= {}
    params[:search].merge!(:user_id_eq => current_user.id)
    respond_with paginated_collection
  end

  def new
    build_resource
    assign_current_year
    super
  end

  def not_mine
    params[:search] ||= {}
    params[:search].merge!(:user_id_not_eq => current_user.id)
    respond_with paginated_collection
  end

  def create
    build_resource.registered_by_id = current_user.id
    super
  end

  def update
    resource.modified_by_id = current_user.id
    super
  end

  def user_list
    respond_with(resource)
  end

  def add_user
    resource_with_user_role.create(user_role_attributes)
    respond_with(resource)
  end

  def del_user
    resource_with_user_role.where(:user_id => current_user.id).first.destroy
    respond_with(resource)
  end

  protected
  def resource_with_user_role
    resource.send(self.user_role_class) 
  end

  def has_resource_class_scope?
    !self.resource_class_scope.nil?
  end

  def scoped_resource_class
    has_resource_class_scope? ? self.resource_class.send(self.resource_class_scope) : self.resource_class
  end

  def user_role_attributes
    { :user_id => current_user.id }.merge(role_attributes)
  end

  def role_attributes
    attributes = self.role_class.nil? ? { } : { self.role_class.to_s.classify.foreign_key => params[self.role_class.to_s.classify.foreign_key.to_sym] }
    if self.user_role_columns.is_a? Array
      self.user_role_columns.each { |name| attributes[name] = params[name] }
    end
    attributes
  end

  def paginated_collection
    set_collection_ivar scoped_resource_class.search(params[:search]).paginate(:page => params[:page] ||1, :per_page => params[:per_page] || 10)
  end

  def assign_current_year
    %w(year startyear endyear).each do |attr|
      if resource.attribute_names.include? attr
        resource.send("#{attr}=", Date.today.year)
      end
    end
  end
end
