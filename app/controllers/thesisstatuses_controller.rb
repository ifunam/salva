class ThesisstatusesController < SuperScaffoldController

   def initialize 
     @model = Thesisstatus
     super
     @find_options = { :order => 'name ASC' }
   end
end