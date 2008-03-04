require 'salva_controller_test'
require 'instadvice_controller'

class InstadviceController; def rescue_action(e) raise e end; end

class  InstadviceControllerTest < SalvaControllerTest
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :instadvicetargets, :userstatuses, :users, :instadvices

  def initialize(*args)
   super
   @mycontroller =  InstadviceController.new
   @myfixtures = {  :title => 'Operacion de equipos de computo_pruebaa', :user_id => 3, :institution_id=> 1, :instadvicetarget_id => 3,  :year => 2005}
   @mybadfixtures = { :title => nil, :user_id => 3, :institution_id=> nil, :instadvicetarget_id => nil,  :year => 2005 }
   @model = Instadvice
   @quickposts = ['institution', 'instadvicetarget']
  end
end
