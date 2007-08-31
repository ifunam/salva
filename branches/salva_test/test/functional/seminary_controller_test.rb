require 'salva_controller_test'
require 'seminary_controller'

class SeminaryController; def rescue_action(e) raise e end; end

class  SeminaryControllerTest < SalvaControllerTest
   fixtures :users, :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :seminaries

  def initialize(*args)
   super
   @mycontroller =  SeminaryController.new
   @myfixtures = {:title => 'Analisis de Onda P____', :isseminary => 'f',  :year =>  2004, :institution_id => 1}
   @mybadfixtures = {:title => nil, :isseminary => 'f',  :year =>  2004, :institution_id => nil   }
    @model = Seminary
   @quickposts = ['Institutions']
 end
end
