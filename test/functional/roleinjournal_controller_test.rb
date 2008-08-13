require 'salva_controller_test'
require 'roleinjournal_controller'

class RoleinjournalController; def rescue_action(e) raise e end; end

class  RoleinjournalControllerTest < SalvaControllerTest
   fixtures :roleinjournals

  def initialize(*args)
   super
   @mycontroller =  RoleinjournalController.new
   @myfixtures = { :name => 'Editor_test' }
   @mybadfixtures = {  :name => nil }
   @model = Roleinjournal
  end
end
