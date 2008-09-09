class DegreesController < SuperScaffoldController

   def initialize 
     @model = Degree
     super
     @find_options = { :order => 'name ASC' }
   end
end