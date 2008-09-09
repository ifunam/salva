class GenericworkstatusesController < SuperScaffoldController

   def initialize 
     @model = Genericworkstatus
     super
     @find_options = { :order => 'name ASC' }
   end
end