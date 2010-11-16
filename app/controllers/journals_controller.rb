class JournalsController < CatalogController 
  autocompleted_search_with :name, :name_like_ignore_case
end