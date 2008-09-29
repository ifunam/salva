class AddressesController < SuperScaffoldController
   def initialize 
     @model = Address
     super
     @find_options = { :order => 'addresstype_id DESC' }
   end
end
