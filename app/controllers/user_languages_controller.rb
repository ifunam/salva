class UserLanguagesController < SuperScaffoldController
   def initialize
     @model = UserLanguage
     super
     @user_session = true
   end
end
