require 'salva_controller_test'
require 'role_controller'

class RoleController; def rescue_action(e) raise e end; end

class  RoleControllerTest < SalvaControllerTest
  fixtures :roles

  def initialize(*args)
   super
   @mycontroller =  RoleController.new
   @myfixtures = { :name => 'mike', :has_group_right => true   }
    @mybadfixtures = { :has_group_right => nil  }
   @model = Role
  end
end
