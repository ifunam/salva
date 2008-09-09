class RoleinjournalsController < SuperScaffoldController

   def initialize 
     @model = Roleinjournal
     super
     @find_options = { :order => 'name ASC' }
   end
end