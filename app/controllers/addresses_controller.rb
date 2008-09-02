class AddressesController < SharedController
  def initialize
    @model = Address
    super
    @columns = %w(location pobox country city state phone fax movil)
  end
end

