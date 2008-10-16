require File.dirname(__FILE__) + '/../test_helper'

class ModelDependentMapperTest < ActiveSupport::TestCase
    fixtures :users, :journals, :publishers

    def setup
      @user_article = ModelDependentMapper.new([UserArticle,[Article, [Journal, Publisher]]])
      # @user_article = ModelDependentMapper.new([UserArticle, [Project]])

      @article_params = { :title => 'Extreme programming with rails',
        :authors => 'Dave Thomas and David Hanson',
        :articlestatus_id => 1,
        :year => Date.today.year
      }
      @journal_params = {       :name=> 'Agile Alliance Magazine',
        :mediatype_id => 2,
        :country_id => 484
      }
      @publisher_params = {
        :name => 'Addison'
      }

      @user_article_params = {
        :ismainauthor => true
      }
    end

    def test_builder
      assert_instance_of ModelDependentMapper, ModelDependentMapper.new([UserArticle,Article])
      #      assert  ModelDependentMapper.new
      #      assert  ModelDependentMapper.new([])
    end

    def test_set_attributes
      @user_article.set_attributes(:article => @article_params, :journal => @journal_params,
                                   :publisher => @publisher_params, :user_article => @user_article_params)
      assert !@user_article.records.empty?
      assert_equal 4, @user_article.records.size

      @user_article.set_attributes('article' => @article_params, 'journal' => @journal_params,
                                   'publisher' => @publisher_params, 'user_article' => @user_article_params)
      assert !@user_article.records.empty?
      assert_equal 4, @user_article.records.size
    end

    def test_set_user
      assert  @user_article.set_user(3)
    end

    #      def test_save
#        @user_article.set_attributes(:article => @article_params, :journal => @journal_params,
#                                     :publisher => @publisher_params, :user_article => @user_article)
#        @user_article.set_user(2)
#        @user_article.save
#        @user_article = UserArticle.first
#        puts @user_article.article.journal.publisher.name

#      end

 #    def test_find
#     end

#     def test_update
#       @user_article.update
#     end

#     def test_destroy
#       @user_article.destroy
#     end
end
