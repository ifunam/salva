require File.dirname(__FILE__) + '/../test_helper'
class UserArticleTest < ActiveSupport::TestCase

   def setup
     @user_article = UserArticle.new
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

  def test_save
    assert_equal [:article, [:journal, [:publisher]]], @user_article.sequence
    @user_article.set_attributes_from('article' => @article_params, 'journal' => @journal_params,
                                      'publisher' => @publisher_params, 'user_article' => @user_article_params)
    #assert_equal [:article, :journal, :publisher], @user_article.records
    @user_article.user_id = 1
    assert_equal 1, @user_article.user_id
    assert @user_article.save
  end
  
  
  def test_update
      @user_article.set_attributes_from('article' => @article_params, 'journal' => @journal_params,
                                        'publisher' => @publisher_params, 'user_article' => @user_article_params)
      @user_article.user_id = 1
      @user_article.save
      
      @user_article = UserArticle.find(:first)
      @user_article.set_attributes_from('article' => @article_params, 'journal' => @journal_params,
                                        'publisher' => @publisher_params, 'user_article' => @user_article_params)
      assert @user_article.save
      assert_equal 1, UserArticle.all.size
  end
  #  
end