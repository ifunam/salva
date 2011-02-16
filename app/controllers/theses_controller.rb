class ThesesController < PublicationController
  defaults :resource_class => Thesis, :collection_name => 'theses', :instance_name => 'thesis',
           :user_role_class => :user_theses, :role_class => :roleintheses
end
