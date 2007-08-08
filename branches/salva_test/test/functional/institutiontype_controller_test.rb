require 'salva_controller_test.rb'
require 'institutiontype_controller'

class Institutiontype_ControllerTest < SalvaControllerTest
  fixtures :institutiontypes , :institutions

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = InstitutiontypeController.new
    @fixtures =  {
       :name  => "Publica social" , :id => 1
    }
    @badfixtures ={ :name => nil , :id=> nil}
    @class = Institutiontype
  end
end
