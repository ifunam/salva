class TechproducttypesController < SuperScaffoldController

   def initialize 
     @model = Techproducttype
     super
     @find_options = { :order => 'name ASC' }
   end
end