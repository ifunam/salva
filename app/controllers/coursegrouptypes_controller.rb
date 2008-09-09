class CoursegrouptypesController < SuperScaffoldController

   def initialize 
     @model = Coursegrouptype
     super
     @find_options = { :order => 'name ASC' }
   end
end