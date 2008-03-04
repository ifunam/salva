require 'salva_controller_test'
require 'user_article_controller'

class UserArticleController; def rescue_action(e) raise e end; end

class  UserArticleControllerTest < SalvaControllerTest
  fixtures :countries, :mediatypes, :publishers, :journals, :articlestatuses, :articles, :user_articles

  def initialize(*args)
   super
   @mycontroller =  UserArticleController.new
   @myfixtures = { :ismainauthor => 't_test', :user_id => 2, :article_id => 1 }
   @mybadfixtures = {  :ismainauthor => nil, :user_id => nil, :article_id => nil }
   @model = UserArticle
   @quickposts = [ 'article' ]
  end
end
