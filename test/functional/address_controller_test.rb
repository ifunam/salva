require 'salva_controller_test'
require 'address_controller'

class AddressController; def rescue_action(e) raise e end; end

class  AddressControllerTest < SalvaControllerTest
  fixtures :userstatuses, :users, :countries, :states, :cities, :addresstypes, :addresses

  def initialize(*args)
   super
   @mycontroller =  AddressController.new
  @myfixtures =  { :location => "Tajín No. 634, Int 1, Col. Letrán Valle, Delegación Benito Juárez",:zipcode => 03650,  :country_id => 484,  :state_id => 9,  :city_id => 64,  :addresstype_id =>  1, :is_postaddress=> true
    }
   @mybadfixtures = {:location => nil, :zipcode => 03650,  :country_id => 484,  :state_id => 9,  :city_id => nil,  :addresstype_id =>  nil, :is_postaddress=> true
    }
   @model = Address
   @quickposts = ['state', 'city']
  end
end
