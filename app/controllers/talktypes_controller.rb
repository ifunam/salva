class TalktypesController < SuperScaffoldController

   def initialize 
     @model = Talktype
     super
     @find_options = { :order => 'name ASC' }
   end
end