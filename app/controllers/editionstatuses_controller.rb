class EditionstatusesController < SuperScaffoldController

   def initialize 
     @model = Editionstatus
     super
     @find_options = { :order => 'name ASC' }
   end
end