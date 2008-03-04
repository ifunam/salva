require 'salva_controller_test'
require 'prize_controller'

class PrizeController; def rescue_action(e) raise e end; end

class  PrizeControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :prizetypes, :prizes

  def initialize(*args)
   super
   @mycontroller =  PrizeController.new
   @myfixtures = { :name => 'Mejor estudio de genero_test', :institution_id => 3, :prizetype_id => 4 }
   @mybadfixtures = {  :name => nil, :institution_id => nil, :prizetype_id => nil, :other => nil }
   @model = Prize
   @quickposts = [ 'prizetype' ]
  end
end
