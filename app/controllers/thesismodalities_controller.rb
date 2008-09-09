class ThesismodalitiesController < SuperScaffoldController

   def initialize 
     @model = Thesismodality
     super
     @find_options = { :order => 'name ASC' }
   end
end