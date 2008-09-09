class BookchaptertypesController < SuperScaffoldController

   def initialize 
     @model = Bookchaptertype
     super
     @find_options = { :order => 'name ASC' }
   end
end