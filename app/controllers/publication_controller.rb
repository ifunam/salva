class PublicationController < InheritedResources::Base
  layout 'publications'

  respond_to :html
  respond_to :js, :only => [:index, :not_mine, :author_list, :add_author, :del_author]

  # Overwritting defaults method 
  class_inheritable_accessor :user_role_class

  def self.defaults(options)
    if options.has_key? :user_role_class
      self.user_role_class = options[:user_role_class]
      options.delete :user_role_class
    end
    super
  end  

  def index
    params[:search] ||= {}
    params[:search].merge!(:user_id_eq => current_user.id)
    respond_with set_collection_ivar(self.resource_class.paginated_search(params))
  end

  def not_mine
    params[:search] ||= {}
    params[:search].merge!(:user_id_not_eq => current_user.id)
    respond_with set_collection_ivar(self.resource_class.paginated_search(params))
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
end
