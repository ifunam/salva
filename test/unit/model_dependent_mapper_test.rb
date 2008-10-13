require File.dirname(__FILE__) + '/../test_helper'

class ModelDependentMapperTest < ActiveSupport::TestCase
    fixtures :users
    
    def setup
      @user_article = ModelDependentMapper.new([UserArticle,[Article, [Journal, Publisher]]])
     # @user_article = ModelDependentMapper.new([UserArticle, [Project]])
    end
    
    def test_builder
      # @user_article = ModelDependentMapper.new([UserArticle,Article])
      assert_instance_of ModelDependentMapper, @user_article
    end
    
    def test_set_attributes
      @user_article.set_attributes(
          :article => {
              :title => 'Extreme programming with rails',
              :authors => 'Dave Thomas and David Hanson',
              :articlestatus_id => 1,
              :year => Date.today.year
              }, 
          :journal => { 
              :name=> 'Agile Alliance Magazine',
              :mediatype_id => 2,
              :country_id => 484
          }, 
          :user_article =>{
            :ismainauthor => true
          },
          :publisher => {
            :name => 'Addison',
          }
      )
      # Probar si los objetos han sido instanciados
    end
     
       #  
       # @article = Article.new({
       #     :title => 'Extreme programming with rails',
       #     :authors => 'Dave Thomas and David Hanson',
       #     :articlestatus_id => 1,
       #     :year => Date.today.year
       #     }) 
       # @journal = Journal.new({ 
       #     :name=> 'Agile Alliance Magazine',
       #     :mediatype_id => 2,
       #     :country_id => 484
       # })
       # @publisher = Publisher.new({
       #   :name => 'Addison',
       # })
       # @user_article = UserArticle.new({
       #   :ismainauthor => true,
       #   :user_id => 2
       # }
       # @user_article.article = @article
       # @user_article.article.journal = @journal
       # @user_article.article.journal.publisher = @publisher
       # @user_article.save
     
    def test_save
    #    @user_article.set_attributes(params)
        @user_article.set_attributes(
            :article => {
                :title => 'Extreme programming with rails',
                :authors => 'Dave Thomas and David Hanson',
                :articlestatus_id => 1,
                :year => Date.today.year
                }, 
            :journal => { 
                :name=> 'Agile Alliance Magazine',
                :mediatype_id => 2,
                :country_id => 484
            }, 
            :publisher => {
              :name => 'Addison',
            },
            :user_article =>{
              :ismainauthor => true
            }
          )
          @user_article.set_user(2)
          @user_article.save
          @user_article = UserArticle.first
          puts @user_article.article.journal.publisher.name
    end
    # 
    # def test_find
    # end
    # 
    # def test_update
    #   #@user_article.update
    # end
    # 
    # def test_destroy
    #   @user_article.destroy
    # end
end