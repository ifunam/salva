class RoleinconferencetalksController < SuperScaffoldController

   def initialize 
     @model = Roleinconferencetalk
     super
     @find_options = { :order => 'name ASC' }
   end
end