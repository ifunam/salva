class UserResearchLinesController < UserResourcesController
  defaults :resource_class => UserResearchline, :collection_name => 'researchlines', :instance_name => 'researchline'
end
