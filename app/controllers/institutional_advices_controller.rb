class InstitutionalAdvicesController < UserResourcesController
  defaults :resource_class => Instadvice, :collection_name => 'advices', :instance_name => 'advice'
end
