class TechproductstatusesController < SuperScaffoldController

   def initialize 
     @model = Techproductstatus
     super
     @find_options = { :order => 'name ASC' }
   end
end