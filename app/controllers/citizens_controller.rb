class CitizensController < SuperScaffoldController
   def initialize
     @model = Citizen
     super
     @user_session = true
     @find_options = { :order => 'citizen_country_id, migratorystatus_id, citizenmodality_id' }
   end
end
