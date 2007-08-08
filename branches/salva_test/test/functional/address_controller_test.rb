#require File.dirname(_FILE_) + '/..test_helper'
require 'salva_controller_test'
require 'address_controller'

# Re-raise errorscaught by the controller.
#class Address_Controller; def rescue_action(e) raise e end; end

class AddressControllerTest < SalvaControllerTest
  fixtures :userstatuses, :users, :countries, :states, :cities, :addresstypes, :addresses

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = AddressController.new
    @fixtures =  {
      :location => "Tajín No. 634, Int 1, Col. Letrán Valle, Delegación Benito Juárez",
      :zipcode => 03650,  :country_id => 484,  :state_id => 9,  :city_id => 64,  :addresstype_id =>  1, :is_postaddress=> true
    }
    @badfixtures = {
      :location => nil,
      :zipcode => 03650,  :country_id => nil,  :state_id => 9,  :city_id => 64,  :addresstype_id =>  1, :is_postaddress=> false
    }
    @model = Address
    @quickposts = ['state:country_id', 'city:state_id']
  end
end

