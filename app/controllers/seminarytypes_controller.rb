class SeminarytypesController < SuperScaffoldController

   def initialize 
     @model = Seminarytype
     super
     @find_options = { :order => 'name ASC' }
   end
end