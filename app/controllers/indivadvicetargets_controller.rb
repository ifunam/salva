class IndivadvicetargetsController < SuperScaffoldController

   def initialize 
     @model = Indivadvicetarget
     super
     @find_options = { :order => 'name ASC' }
   end
end