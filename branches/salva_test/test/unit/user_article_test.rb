require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'article'
require 'user_article'

class UserArticleTest < Test::Unit::TestCase
fixtures  :userstatuses, :users, :countries, :mediatypes, :publishers, :journals, :articlestatuses, :articles, :user_articles
 
  def setup
    @user_articles = %w(hernandez_operacion_del_radiotelescopio cedillo_barrancos_en_marte)
    @myuser_article = UserArticle.new({:user_id => 2, :article_id => 2, :ismainauthor => 'f'})
  end

  # Right - CRUD
  def test_creating_user_articles_from_yaml
    @user_articles.each { | user_article|
      @user_article = UserArticle.find(user_articles(user_article.to_sym).id)
      assert_kind_of UserArticle, @user_article
      assert_equal user_articles(user_article.to_sym).id, @user_article.id
      assert_equal user_articles(user_article.to_sym).user_id, @user_article.user_id
      assert_equal user_articles(user_article.to_sym).article_id, @user_article.article_id
    }
  end

  def test_deleting_user_articles
    @user_articles.each { |user_article|
      @user_article = UserArticle.find(user_articles(user_article.to_sym).id)
      @user_article.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserArticle.find(user_articles(user_article.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_article = UserArticle.new
    assert !@user_article.save
  end

  def test_creating_duplicated_user_article
   @user_article = UserArticle.new({:user_id => 3, :article_id => 2, :ismainauthor => 't'})
   #@user_article = UserArticle.new({:ismainauthor => 't'})
   #@user_article.id=2
   assert !@user_article.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuser_article.id = 1.6
    assert !@myuser_article.valid?
    @myuser_article.id = 'mi_id'
    assert !@myuser_article.valid?
  end

  def test_bad_values_for_user_id
    @myuser_article.user_id = nil
    assert !@myuser_article.valid?

    @myuser_article.user_id= 1.6
    assert !@myuser_article.valid?

    @myuser_article.user_id = 'mi_id'
    assert !@myuser_article.valid?
  end

  def test_bad_values_for_article_id
    @myuser_article.article_id = nil
    assert !@myuser_article.valid?

    @myuser_article.article_id = 3.1416
    assert !@myuser_article.valid?
    @myuser_article.article_id = 'mi_id'
    assert !@myuser_article.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_article_id
    @user_articles.each { | user_article|
      @user_article = UserArticle.find(user_articles(user_article.to_sym).id)
      assert_kind_of UserArticle, @user_article
      assert_equal @user_article.article_id, Article.find(@user_article.article_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_article_id
    @user_articles.each { | user_article|
      @user_article = UserArticle.find(user_articles(user_article.to_sym).id)
      assert_kind_of UserArticle, @user_article
      @user_article.article_id = 1000000
      begin
        return true if @user_article.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_user_id
    @user_articles.each { | user_article|
      @user_article = UserArticle.find(user_articles(user_article.to_sym).id)
      assert_kind_of UserArticle, @user_article
      assert_equal @user_article.user_id, User.find(@user_article.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @user_articles.each { | user_article|
      @user_article = UserArticle.find(user_articles(user_article.to_sym).id)
      assert_kind_of UserArticle, @user_article
      @user_article.user_id = 100000
      begin
        return true if @user_article.update
      rescue StandardError => x
        return false
      end
    }
  end

end
