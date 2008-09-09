class ModalitiesController < SuperScaffoldController

   def initialize 
     @model = Modality
     super
     @find_options = { :order => 'name ASC' }
   end
end