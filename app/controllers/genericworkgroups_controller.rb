class GenericworkgroupsController < SuperScaffoldController

   def initialize 
     @model = Genericworkgroup
     super
     @find_options = { :order => 'name ASC' }
   end
end