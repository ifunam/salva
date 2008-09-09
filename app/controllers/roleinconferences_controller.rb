class RoleinconferencesController < SuperScaffoldController

   def initialize 
     @model = Roleinconference
     super
     @find_options = { :order => 'name ASC' }
   end
end