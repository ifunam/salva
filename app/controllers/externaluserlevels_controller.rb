class ExternaluserlevelsController < SuperScaffoldController

   def initialize 
     @model = Externaluserlevel
     super
     @find_options = { :order => 'name ASC' }
   end
end