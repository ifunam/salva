require 'salva_controller_test'
require 'group_controller'

class GroupController; def rescue_action(e) raise e end; end

class  GroupControllerTest < SalvaControllerTest
   fixtures :groups

  def initialize(*args)
   super
   @mycontroller =  GroupController.new
   @myfixtures = { :name => 'Secretaría Académica_test' }
   @mybadfixtures = {  :name => nil }
   @model = Group
  end
end
