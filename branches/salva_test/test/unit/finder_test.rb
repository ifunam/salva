require File.dirname(__FILE__) + '/../test_helper'
require 'finder'
class FinderTest < Test::Unit::TestCase
  fixtures  :userstatuses, :users, :countries, :mediatypes, :publishers, :journals, :articlestatuses, :articles, :user_articles

  def setup
    @user_article_finder  = Finder.new(UserArticle, :attributes => ['article', 'title', ['journal', 'name']])
    @country_finder  = Finder.new(Country)
    @article_finder  = Finder.new(Article)
    @user_article_simple  = Finder.new(UserArticle)
    @country_finder_first = Finder.new(Country, :first)
  end
  
  def test_initialize
    assert_instance_of Finder, Finder.new(UserArticle, :attributes => ['article', 'title', ['journal', 'name']])
    assert_instance_of Finder, Finder.new(UserArticle, :all, :attributes => ['article', 'title', ['journal', 'name']])
    assert_instance_of Finder, Finder.new(Country)
    assert_instance_of Finder, Finder.new(Article)
    assert_instance_of Finder, Finder.new(UserArticle)
    assert_instance_of Finder,Finder.new(Country, :first)
  end
  
  def test_tableize
    assert_equal 'user_articles',  @user_article_finder.tableize('user_article')
    assert_equal 'articles',  @user_article_finder.tableize('article')
    assert_equal 'journals',  @user_article_finder.tableize('journal')
  end

  def test_build_select
    args = [UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor', ['city', 'name']]
    assert_equal 'articles.title AS articles_title, journals.name AS journals_name, countries.name AS countries_name, user_articles.ismainauthor AS user_articles_ismainauthor, cities.name AS cities_name', @user_article_finder.build_select(*args)
    args = [UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor']
    assert_equal 'articles.title AS articles_title, journals.name AS journals_name, countries.name AS countries_name, user_articles.ismainauthor AS user_articles_ismainauthor', @user_article_finder.build_select(*args)
  end

  def test_set_tables
    args = [UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor']
    assert_equal 'user_articles, articles, journals, countries', @user_article_finder.set_tables(*args).join(', ')
    args = [UserArticle, ['article', 'title', ['journal', 'name']], 'ismainauthor']
    assert_equal 'user_articles, articles, journals', @user_article_finder.set_tables(*args).join(', ')
    args = [UserArticle, 'ismainauthor']
    assert_equal 'user_articles', @user_article_finder.set_tables(*args).join(', ')
  end

  def  test_build_conditions
    args =[UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor']
    assert_equal 'user_articles.article_id = articles.id  AND articles.journal_id = journals.id  AND journals.country_id = countries.id ', @user_article_finder.build_conditions(*args).join(' AND ')
  end

  def test_sql
    assert_equal "    SELECT user_articles.id AS id, articles.title AS articles_title, journals.name AS journals_name\n    FROM user_articles, articles, journals\n    WHERE user_articles.article_id = articles.id  AND articles.journal_id = journals.id \n", @user_article_finder.sql
  end

  def test_as_text
    assert_equal ['Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS', 'Estudio de barrancos en Marte, QUO'],  @user_article_finder.as_text
  end

  def test_as_pair
    assert_equal [['Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS', 1],  ['Estudio de barrancos en Marte, QUO', 2]],  @user_article_finder.as_pair
  end

  def test_as_hash
    assert_equal [ ['user_article', 'Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS'], ['user_article','Estudio de barrancos en Marte, QUO']],  @user_article_finder.as_hash
  end

  def test_set_attributes
    assert_equal 'name', @country_finder.set_attributes
    assert_equal 'title', @article_finder.set_attributes
    assert_equal 'article_id, ismainauthor, other',  @user_article_simple.set_attributes
    assert_equal 'name', @country_finder_first.set_attributes
  end

  def test_simple_sql
    assert_equal "SELECT id, name  FROM countries ORDER BY name ASC",  @country_finder.sql
    assert_equal "SELECT id, title  FROM articles ORDER BY title ASC", @article_finder.sql
    assert_equal "SELECT id, article_id, ismainauthor, other  FROM user_articles ORDER BY article_id, ismainauthor, other ASC", @user_article_simple.sql
    assert_equal "SELECT id, name  FROM countries ORDER BY name ASC LIMIT 1",  @country_finder_first.sql
  end

  def test_as_text_simple_sql
    assert_equal ["Estados Unidos", "Japón", "México", "Ucrania"], @country_finder.as_text
    assert_equal ["Estudio de barrancos en Marte", "Operacion del Radiotelescopio de Centelleo Interplanetario"], @article_finder.as_text
    assert_equal ["1, Autor principal", "2, Autor principal"], @user_article_simple.as_text
  end

  def test_as_pair_simple_sql
    assert_equal [["Estados Unidos", 666], ["Japón", 392], ["México", 484], ["Ucrania", 804]], @country_finder.as_pair
    assert_equal [["Estudio de barrancos en Marte", 2], ["Operacion del Radiotelescopio de Centelleo Interplanetario", 1]], @article_finder.as_pair
    assert_equal [["1, Autor principal", 1], ["2, Autor principal", 2]], @user_article_simple.as_pair
  end

  def test_as_hash_simple_sql
    assert_equal [["country", "Estados Unidos"], ["country", "Japón"], ["country", "México"], ["country", "Ucrania"]], @country_finder.as_hash
    assert_equal [["article", "Estudio de barrancos en Marte"], ["article", "Operacion del Radiotelescopio de Centelleo Interplanetario"]], @article_finder.as_hash
    assert_equal [["user_article", "1, Autor principal"], ["user_article", "2, Autor principal"]], @user_article_simple.as_hash
  end
  
  def test_complex_conditions
    @f = Finder.new(Addresstype, :conditions => "addresstypes.id NOT IN (SELECT addresstypes.id FROM addresstypes, addresses WHERE addresses.addresstype_id = addresstypes.id AND addresses.user_id = 2)")
    assert_equal 'SELECT id, name  FROM addresstypes WHERE addresstypes.id NOT IN (SELECT addresstypes.id FROM addresstypes, addresses WHERE addresses.addresstype_id = addresstypes.id AND addresses.user_id = 2) ORDER BY name ASC', @f.sql
  end
end
