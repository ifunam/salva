class ConferencescopesController < SuperScaffoldController

   def initialize 
     @model = Conferencescope
     super
     @find_options = { :order => 'name ASC' }
   end
end