class PublicationController < InheritedResources::Base
  layout 'publications'

  respond_to :html
  respond_to :js, :only => [:index, :not_mine, :user_list, :add_user, :del_user, :role_list]

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
    resource_default_year
    super
  end

  def not_mine
    params[:search] ||= {}
    params[:search].merge!(:user_id_not_eq => current_user.id)
    respond_with paginated_collection
  end

  def create
    set_user_in_role_class!
    build_resource.registered_by_id = current_user.id
    create! { collection_url }
  end

  def update
    set_user_in_role_class!
    resource.modified_by_id = current_user.id
    update! { collection_url }
  end

  def destroy
    authorize_action!
    destroy_associated_records!
    super
  end

  def destroy_all
    if params[:ids] and params[:ids].is_a? Array
      respond_with(destroy_all_selected_records!, :status => :deleted_records) do |format|
        format.js { render :nothing => true }
      end
    end
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

  def has_role_class_name?
    defined? self.user_role_class
  end

  def resource_role_class_name
    ActiveSupport::Inflector.classify(self.user_role_class).constantize if has_role_class_name?
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
    set_collection_ivar scoped_resource_class.search(params[:search]).page(params[:page] ||1).per(params[:per_page] || 10)
  end

  def resource_default_year
    %w(year startyear endyear).each do |attr|
      if resource.attribute_names.include? attr
        resource.send("#{attr}=", Documenttype.year_for_annual_report)
      end
    end
  end

  def authorize_action!
    unless resource.registered_by_id == current_user.id
      authorize! :unauthorized, resource.class.name, :message => "Unable to delete this record."
    end
  end

  def set_user_in_role_class!
    if has_role_class_name?
      resource_params.first[self.user_role_class.to_s+'_attributes'].first.last.merge!(:user_id => current_user.id)
    end
  end

  def destroy_associated_records!
    destroy_role_records!(resource.id) if has_role_class_name?
  end

  def destroy_role_records!(record_id)
    if has_role_class_name?
      foreign_key = ActiveSupport::Inflector.foreign_key(resource_class)
      resource_role_class_name.destroy_all(:user_id => current_user.id, foreign_key.to_sym => record_id.to_i)
    end
  end

  def destroy_all_selected_records!
    resource_class.find(params[:ids].to_a).collect { |record|
      if record.registered_by_id == current_user.id
        destroy_role_records!(record.id)
        record.destroy
        nil
      else
        record
      end
    }.compact
  end
end
