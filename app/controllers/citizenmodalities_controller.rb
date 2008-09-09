class CitizenmodalitiesController < SuperScaffoldController

   def initialize 
     @model = Citizenmodality
     super
     @find_options = { :order => 'name ASC' }
   end
end