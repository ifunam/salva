require 'salva_controller_test'
require 'credential_controller'

class CredentialController; def rescue_action(e) raise e end; end

class  CredentialControllerTest < SalvaControllerTest
   fixtures :credentials

  def initialize(*args)
   super
   @mycontroller =  CredentialController.new
   @myfixtures = { :name => 'Pasante_test', :abbrev => 'Pasante_test' }
   @mybadfixtures = {  :name => nil, :abbrev => nil }
   @model = Credential
  end
end
