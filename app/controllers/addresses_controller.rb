require 'finder'
class AddressesController < SalvaController
  def initialize
    @model  = Address
    super
    @columns = %w(addresstype location pobox country state city zipcode phone movil other)
  end
end

