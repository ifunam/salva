class LanguagesController < SuperScaffoldController

   def initialize 
     @model = Language
     super
     @find_options = { :order => 'name ASC' }
   end
end