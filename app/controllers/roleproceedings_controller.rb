class RoleproceedingsController < SuperScaffoldController

   def initialize 
     @model = Roleproceeding
     super
     @find_options = { :order => 'name ASC' }
   end
end