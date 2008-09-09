class MigratorystatusesController < SuperScaffoldController

   def initialize 
     @model = Migratorystatus
     super
     @find_options = { :order => 'name ASC' }
   end
end