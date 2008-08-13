require 'salva_controller_test'
require 'genericworktype_controller'

class GenericworktypeController; def rescue_action(e) raise e end; end

class  GenericworktypeControllerTest < SalvaControllerTest
   fixtures :genericworkgroups, :genericworktypes

  def initialize(*args)
   super
   @mycontroller =  GenericworktypeController.new
   @myfixtures = { :name => 'Catálogos_test', :genericworkgroup_id => 4 }
   @mybadfixtures = {  :name => nil, :genericworkgroup_id => nil }
   @model = Genericworktype
  end
end
