class RoleinchaptersController < SuperScaffoldController

   def initialize 
     @model = Roleinchapter
     super
     @find_options = { :order => 'name ASC' }
   end
end