class ThesesController < PublicationController
  defaults :resource_class => Thesis.not_as_author, :collection_name => 'theses', :instance_name => 'thesis',
           :user_role_class => :user_theses, :role_class => :roleintheses

  def update
    set_user_in_role_class!
    resource.modified_by_id = current_user.id
    update!
  end
end
