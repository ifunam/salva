require 'salva_controller_test'
require 'genericwork_controller'

class GenericworkController; def rescue_action(e) raise e end; end

class  GenericworkControllerTest < SalvaControllerTest
fixtures :genericworkgroups, :genericworktypes, :genericworkstatuses, :genericworks

  def initialize(*args)
   super
   @mycontroller =  GenericworkController.new
   @myfixtures = {:title => ' Comunicaciones_tecnicas ', :authors => ' Andres Silva, Imelda Hernandez, Roberto Martinez', :genericworktype_id => 5, :genericworkstatus_id => 3, :year =>  2007}
   @mybadfixtures = {:title => ' Comunicaciones_tecnicas ', :authors => nil, :genericworktype_id => nil, :genericworkstatus_id => 3, :year =>  nil   }
   @model = Genericwork
   @quickpost =  ['institution']
  end
end
