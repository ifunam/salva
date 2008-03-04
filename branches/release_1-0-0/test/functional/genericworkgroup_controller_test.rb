require 'salva_controller_test'
require 'genericworkgroup_controller'

class GenericworkgroupController; def rescue_action(e) raise e end; end

class  GenericworkgroupControllerTest < SalvaControllerTest
   fixtures :genericworkgroups

  def initialize(*args)
   super
   @mycontroller =  GenericworkgroupController.new
   @myfixtures = { :name => 'Publicaciones_test' }
   @mybadfixtures = {  :name => nil }
   @model = Genericworkgroup
  end
end
