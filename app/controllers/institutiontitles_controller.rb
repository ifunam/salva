class InstitutiontitlesController < SuperScaffoldController

   def initialize 
     @model = Institutiontitle
     super
     @find_options = { :order => 'name ASC' }
   end
end