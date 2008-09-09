class JobpositionlevelsController < SuperScaffoldController

   def initialize 
     @model = Jobpositionlevel
     super
     @find_options = { :order => 'name ASC' }
   end
end