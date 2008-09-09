class JobpositiontypesController < SuperScaffoldController

   def initialize 
     @model = Jobpositiontype
     super
     @find_options = { :order => 'name ASC' }
   end
end