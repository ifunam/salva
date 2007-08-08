require 'salva_controller_test'
require 'acadvisittype_controller'

class Acadvisittype_Controller_Test < SalvaControllerTest
  fixtures :acadvisittypes
  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = AcadvisittypeController.new
    @fixtures =  {
    :name => 'sabatico',
    :id => 1
    }
    @badfixtures ={
   :name => nil
     }
     @model = Acadvisittype
  end
end
