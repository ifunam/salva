class AcademicprogramtypesController < SuperScaffoldController

   def initialize 
     @model = Academicprogramtype
     super
     @find_options = { :order => 'name ASC' }
   end
end