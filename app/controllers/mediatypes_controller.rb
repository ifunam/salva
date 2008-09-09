class MediatypesController < SuperScaffoldController

   def initialize 
     @model = Mediatype
     super
     @find_options = { :order => 'name ASC' }
   end
end