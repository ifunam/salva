class OutreachWorksController < PublicationController
  defaults :resource_class => Genericwork, :collection_name => 'genericworks', :instance_name => 'genericwork',
           :resource_class_scope => :outreach_works,
           :user_role_class => :user_genericworks, :role_class => :userrole
end
