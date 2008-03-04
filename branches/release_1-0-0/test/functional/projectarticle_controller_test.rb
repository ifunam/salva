require 'salva_controller_test'
require 'projectarticle_controller'

class ProjectarticleController; def rescue_action(e) raise e end; end

class  ProjectarticleControllerTest < SalvaControllerTest
  fixtures :projecttypes,:projectstatuses,:projects, :articlestatuses, :countries, :mediatypes, :publishers, :journals, :articles, :projectarticles

  def initialize(*args)
   super
   @mycontroller =  ProjectarticleController.new
   @myfixtures = {:project_id=>3, :article_id =>1}
   @mybadfixtures = {:project_id=>nil, :article_id =>nil  }
   @model = Projectarticle
   @quickposts = ['article']
  end
end
