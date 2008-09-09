class RoleinjobpositionsController < SuperScaffoldController

   def initialize 
     @model = Roleinjobposition
     super
     @find_options = { :order => 'name ASC' }
   end
end