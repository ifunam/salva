class StudentrolesController < SuperScaffoldController

   def initialize 
     @model = Studentrole
     super
     @find_options = { :order => 'name ASC' }
   end
end