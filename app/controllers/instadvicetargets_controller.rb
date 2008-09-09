class InstadvicetargetsController < SuperScaffoldController

   def initialize 
     @model = Instadvicetarget
     super
     @find_options = { :order => 'name ASC' }
   end
end