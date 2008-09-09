class ActivitygroupsController < SuperScaffoldController

   def initialize 
     @model = Activitygroup
     super
     @find_options = { :order => 'name ASC' }
   end
end