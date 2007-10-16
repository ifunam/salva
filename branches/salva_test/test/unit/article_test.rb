require File.dirname(__FILE__) + '/../test_helper'
require 'articlestatus'
require 'journal'
require 'article'

class ArticleTest < Test::Unit::TestCase
  fixtures :countries, :mediatypes, :publishers, :journals, :articlestatuses, :articles

  def setup
    #@articles = %w(operacion_del_radiotelescopio_de_centelleo_interplanetario estudio_de_formacion_de_barrancos_en_marte)
    @articles = %w(operacion_del_radiotelescopio_de_centelleo_interplanetario Estudio_de_formacion_de_barrancos_en_Marte)
    @myarticle = Article.new({ :title => 'Cómo hacer un centro científico exitoso', :journal_id => 3, :articlestatus_id => 3, :year => 2006, :authors  => 'Flores J.' })
  end

  # Right - CRUD
  def test_creating_articles_from_yaml
    @articles.each { | article|
      @article = Article.find(articles(article.to_sym).id)
      assert_kind_of Article, @article
      assert_equal articles(article.to_sym).id, @article.id
      assert_equal articles(article.to_sym).title, @article.title
      assert_equal articles(article.to_sym).authors, @article.authors
      assert_equal articles(article.to_sym).journal_id, @article.journal_id
      assert_equal articles(article.to_sym).articlestatus_id, @article.articlestatus_id
      assert_equal articles(article.to_sym).year, @article.year
    }
  end

  def test_updating_article_title
    @articles.each { |article|
      @article = Article.find(articles(article.to_sym).id)
      assert_equal articles(article.to_sym).title, @article.title
      @article.title = @article.title.chars.reverse 
      assert @article.save
      assert_not_equal articles(article.to_sym).title, @article.title
    }
  end

  def test_updating_article_authors
    @articles.each { |article|
      @article = Article.find(articles(article.to_sym).id)
      assert_equal articles(article.to_sym).authors, @article.authors
      @article.authors = @article.authors.chars.reverse 
      assert @article.save
      assert_not_equal articles(article.to_sym).authors, @article.authors
    }
  end  

  def test_deleting_articles
    @articles.each { |article|
      @article = Article.find(articles(article.to_sym).id)
      @article.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Article.find(articles(article.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @article = Article.new
    assert !@article.save
  end

  def test_creating_duplicated_article
    @article = Article.new({:title => 'Operacion del Radiotelescopio de Centelleo Interplanetario', :journal_id => 2, :articlestatus_id => 1,  :year => 2006, :authors  => 'J. A. Hernandez, Cinthya Bell'})
    assert !@article.save

  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myarticle.id = 1.6
    assert !@myarticle.valid?
    @myarticle.id = 'mi_id'
    assert !@myarticle.valid?
  end

  def test_bad_values_for_journal_id
    @myarticle.journal_id = nil
    assert !@myarticle.valid?

    @myarticle.journal_id= 1.6
    assert !@myarticle.valid?

    @myarticle.journal_id = 'mi_id'
    assert !@myarticle.valid?
  end

  def test_bad_values_for_articlestatus_id
    @myarticle.articlestatus_id = nil
    assert !@myarticle.valid?

    @myarticle.articlestatus_id = 3.1416
    assert !@myarticle.valid?
    @myarticle.articlestatus_id = 'mi_id'
    assert !@myarticle.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_articlestatus_id
    @articles.each { | article|
      @article = Article.find(articles(article.to_sym).id)
      assert_kind_of Article, @article
      assert_equal @article.articlestatus_id, Articlestatus.find(@article.articlestatus_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_articlestatus_id
    @articles.each { | article|
      @article = Article.find(articles(article.to_sym).id)
      assert_kind_of Article, @article
      @article.articlestatus_id = 1000000
      begin
        return true if @article.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_journal_id
    @articles.each { | article|
      @article = Article.find(articles(article.to_sym).id)

      assert_kind_of Article, @article
      assert_equal @article.journal_id, Journal.find(@article.journal_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_journal_id
    @articles.each { | article|
      @article = Article.find(articles(article.to_sym).id)
      assert_kind_of Article, @article
      @article.journal_id = 100000
      begin
        return true if @article.save
      rescue StandardError => x
        return false
      end
    }
  end

end
