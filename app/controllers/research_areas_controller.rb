class ResearchAreasController < CatalogController
  defaults :resource_class => Researcharea, :collection_name => 'research_areas', :instance_name => 'research_area'

  autocompleted_search_with :name, :name_like_ignore_case
end