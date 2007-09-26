require 'salva_controller_test'
require 'newspaper_controller'

class NewspaperController; def rescue_action(e) raise e end; end

class  NewspaperControllerTest < SalvaControllerTest
   fixtures :countries, :newspapers

  def initialize(*args)
   super
   @mycontroller =  NewspaperController.new
   @myfixtures = { :name => 'El Sur de Campeche_test', :url => 'http://www.elsur.com.mx/_test', :country_id => 484 }
   @mybadfixtures = {  :name => nil, :url => nil, :country_id => nil }
   @model = Newspaper
  end
end
