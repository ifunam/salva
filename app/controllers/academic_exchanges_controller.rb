class AcademicExchangesController < UserResourcesController
  defaults :resource_class => Acadvisit, :collection_name => 'academic_exchanges', :instance_name => 'academic_exchange'
end