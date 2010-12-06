class ProfessorAdvicesController < UserResourcesController
  defaults :resource_class => Indivadvice, :collection_name => 'advices', :instance_name => 'advice',
           :resource_class_scope => :professors
end
