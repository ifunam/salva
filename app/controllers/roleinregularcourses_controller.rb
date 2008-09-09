class RoleinregularcoursesController < SuperScaffoldController

   def initialize 
     @model = Roleinregularcourse
     super
     @find_options = { :order => 'name ASC' }
   end
end