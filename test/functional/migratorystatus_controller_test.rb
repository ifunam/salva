require 'salva_controller_test'
require 'migratorystatus_controller'

class MigratorystatusController; def rescue_action(e) raise e end; end

class  MigratorystatusControllerTest < SalvaControllerTest
  fixtures :migratorystatuses

  def initialize(*args)
   super
   @mycontroller =  MigratorystatusController.new
   @myfixtures = {:name => 'mojado'}
   @mybadfixtures = {:name => nil   }
   @model = Migratorystatus
  end
end
