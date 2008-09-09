class RoleincoursesController < SuperScaffoldController

   def initialize 
     @model = Roleincourse
     super
     @find_options = { :order => 'name ASC' }
   end
end