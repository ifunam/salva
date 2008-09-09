class AcadvisittypesController < SuperScaffoldController

   def initialize 
     @model = Acadvisittype
     super
     @find_options = { :order => 'name ASC' }
   end
end