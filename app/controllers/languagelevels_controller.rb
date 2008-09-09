class LanguagelevelsController < SuperScaffoldController

   def initialize 
     @model = Languagelevel
     super
     @find_options = { :order => 'name ASC' }
   end
end