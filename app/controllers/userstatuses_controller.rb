class UserstatusesController < SuperScaffoldController

   def initialize 
     @model = Userstatus
     super
     @find_options = { :order => 'name ASC' }
   end
end