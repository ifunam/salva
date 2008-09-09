class RoleinseminariesController < SuperScaffoldController

   def initialize 
     @model = Roleinseminary
     super
     @find_options = { :order => 'name ASC' }
   end
end