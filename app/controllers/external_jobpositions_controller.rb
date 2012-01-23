class ExternalJobpositionsController < UserResourcesController
  defaults :resource_class => Jobposition, :collection_name => 'jobpositions', :instance_name => 'jobposition',
           :resource_class_scope => :at_external_institutions
end
