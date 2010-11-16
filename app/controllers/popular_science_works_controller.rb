class PopularScienceWorksController < PublicationController
  defaults :resource_class => Genericwork, :collection_name => 'genericworks', :instance_name => 'genericwork',
           :resource_class_scope => :popular_science,
           :user_role_class => :user_genericworks, :role_class => :userrole
end
