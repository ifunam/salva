class ConferencetypesController < SuperScaffoldController

   def initialize 
     @model = Conferencetype
     super
     @find_options = { :order => 'name ASC' }
   end
end