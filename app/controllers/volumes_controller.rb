class VolumesController < SuperScaffoldController

   def initialize 
     @model = Volume
     super
     @find_options = { :order => 'name ASC' }
   end
end