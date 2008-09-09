class ProjecttypesController < SuperScaffoldController

   def initialize 
     @model = Projecttype
     super
     @find_options = { :order => 'name ASC' }
   end
end