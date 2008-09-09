class ContracttypesController < SuperScaffoldController

   def initialize 
     @model = Contracttype
     super
     @find_options = { :order => 'name ASC' }
   end
end