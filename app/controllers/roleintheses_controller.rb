class RoleinthesesController < SuperScaffoldController

   def initialize 
     @model = Roleinthesis
     super
     @find_options = { :order => 'name ASC' }
   end
end