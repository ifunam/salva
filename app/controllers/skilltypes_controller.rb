class SkilltypesController < SuperScaffoldController

   def initialize 
     @model = Skilltype
     super
     @find_options = { :order => 'name ASC' }
   end
end