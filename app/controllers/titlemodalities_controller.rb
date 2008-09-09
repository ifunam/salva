class TitlemodalitiesController < SuperScaffoldController

   def initialize 
     @model = Titlemodality
     super
     @find_options = { :order => 'name ASC' }
   end
end