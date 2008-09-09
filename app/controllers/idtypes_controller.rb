class IdtypesController < SuperScaffoldController

   def initialize 
     @model = Idtype
     super
     @find_options = { :order => 'name ASC' }
   end
end