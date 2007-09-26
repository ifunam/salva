require 'salva_controller_test'
require 'institutiontype_controller'

class InstitutiontypeController; def rescue_action(e) raise e end; end

class  InstitutiontypeControllerTest < SalvaControllerTest
   fixtures :institutiontypes

  def initialize(*args)
   super
   @mycontroller =  InstitutiontypeController.new
   @myfixtures = { :name => 'Privada_test' }
   @mybadfixtures = {  :name => nil }
   @model = Institutiontype
  end
end
