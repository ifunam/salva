class PopularScienceActivitiesController < UserResourcesController
  defaults :resource_class => Activity, :collection_name => 'activities', :instance_name => 'activity',
           :resource_class_scope => :popular_science
end