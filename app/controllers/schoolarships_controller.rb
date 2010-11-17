class SchoolarshipsController < CatalogController 
  autocompleted_search_with :name, :name_like_ignore_case, :name_and_institution_abbrev
end