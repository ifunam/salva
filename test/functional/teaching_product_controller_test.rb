require 'salva_controller_test'
require 'teaching_product_controller'

class TeachingProductController; def rescue_action(e) raise e end; end

class  TeachingProductControllerTest < SalvaControllerTest
   fixtures  :genericworkgroups, :genericworktypes, :genericworkstatuses, :genericworks

  def initialize(*args)
   super
   @mycontroller =  TeachingProductController.new
   @myfixtures = { :genericworkstatus_id => 3, :genericworktype_id => 5, :title => 'Comunicaciones_tecnicas_test', :year => 2007, :authors => 'Andres Silva, Imelda Hernandez, Roberto Martinez_test' }
   @mybadfixtures = {  :genericworkstatus_id => nil, :genericworktype_id => nil, :title => nil, :year => nil, :authors => nil }
   @model = Genericwork
   @quickposts = [ 'genericworktype' ]
  end
end
