class RoleinprojectsController < SuperScaffoldController

   def initialize 
     @model = Roleinproject
     super
     @find_options = { :order => 'name ASC' }
   end
end