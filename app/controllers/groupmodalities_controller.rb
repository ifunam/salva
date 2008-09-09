class GroupmodalitiesController < SuperScaffoldController

   def initialize 
     @model = Groupmodality
     super
     @find_options = { :order => 'name ASC' }
   end
end