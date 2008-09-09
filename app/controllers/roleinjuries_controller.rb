class RoleinjuriesController < SuperScaffoldController

   def initialize 
     @model = Roleinjury
     super
     @find_options = { :order => 'name ASC' }
   end
end