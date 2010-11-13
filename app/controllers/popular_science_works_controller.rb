class PopularScienceWorksController < PublicationController
  defaults :resource_class => Genericwork, :collection_name => 'genericworks', :instance_name => 'genericwork',
           :user_role_class => :user_genericworks, :resource_class_scope => :popular_science
end
