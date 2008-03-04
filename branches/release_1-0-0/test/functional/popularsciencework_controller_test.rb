require 'salva_controller_test'
require 'popularsciencework_controller'

class PopularscienceworkController; def rescue_action(e) raise e end; end

class  PopularscienceworkControllerTest < SalvaControllerTest
   fixtures  :genericworkgroups, :genericworktypes, :genericworkstatuses, :genericworks

  def initialize(*args)
   super
   @mycontroller =  PopularscienceworkController.new
   @myfixtures = { :genericworkstatus_id => 3, :title => 'Comunicaciones_tecnicas_test', :genericworktype_id => 5, :year => 2007, :authors => 'Andres Silva, Imelda Hernandez, Roberto Martinez_test' }
   @mybadfixtures = {  :genericworkstatus_id => nil, :title => nil, :genericworktype_id => nil, :year => nil, :authors => nil }
   @model = Genericwork
  end
end
