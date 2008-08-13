require 'salva_controller_test'
require 'article_controller'

class ArticleController; def rescue_action(e) raise e end; end

class  ArticleControllerTest < SalvaControllerTest
  fixtures  :countries, :mediatypes, :publishers, :journals, :articlestatuses, :articles

  def initialize(*args)
   super
   @mycontroller =  ArticleController.new
   @myfixtures = { :title => 'Operacion del Radiotelescopio de Centelleo Interplanetario ___prueba', :journal_id => 2, :articlestatus_id => 1,  :year => 2006,  :authors =>' J. A. Hernandez, Cinthya Bell'}
   @mybadfixtures = {:title => nil, :journal_id => 2, :articlestatus_id => 1,  :year => 2006,  :authors => nil }
   @model = Article
   @quickposts = ['journal']
  end
end
