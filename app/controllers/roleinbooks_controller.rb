class RoleinbooksController < SuperScaffoldController

   def initialize 
     @model = Roleinbook
     super
     @find_options = { :order => 'name ASC' }
   end
end