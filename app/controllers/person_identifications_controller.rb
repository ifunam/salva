class PersonIdentificationsController < SuperScaffoldController
     def initialize
     @model = PeopleIdentification
     super
     @user_session = true
   end
end
