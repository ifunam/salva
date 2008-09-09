class ProjectstatusesController < SuperScaffoldController

   def initialize 
     @model = Projectstatus
     super
     @find_options = { :order => 'name ASC' }
   end
end