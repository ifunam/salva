class UserrolesController < SuperScaffoldController

   def initialize 
     @model = Userrole
     super
     @find_options = { :order => 'name ASC' }
   end
end