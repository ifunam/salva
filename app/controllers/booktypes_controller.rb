class BooktypesController < SuperScaffoldController

   def initialize 
     @model = Booktype
     super
     @find_options = { :order => 'name ASC' }
   end
end