class AddressesController < SuperScaffoldController
   def initialize
     @model = Address
     super
     @user_session = true
     @find_options = { :order => 'addresstype_id DESC'}
   end
end

