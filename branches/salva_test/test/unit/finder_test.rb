require File.dirname(__FILE__) + '/../test_helper'
require 'finder'
class FinderTest < Test::Unit::TestCase
  fixtures  :userstatuses, :users, :countries, :mediatypes, :publishers, :journals, :articlestatuses, :articles, :user_articles

  def setup
    @f  = Finder.new(UserArticle, ['article', 'title', ['journal', 'name']], :all)
  end

  def test_tableize
    assert_equal 'user_articles',  @f.tableize('user_article')
    assert_equal 'articles',  @f.tableize('article')
    assert_equal 'journals',  @f.tableize('journal')
  end

    def test_build_select
      args = [UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor', ['city', 'name']]
      assert_equal 'articles.title AS articles_title, journals.name AS journals_name, countries.name AS countries_name, user_articles.ismainauthor AS user_articles_ismainauthor, cities.name AS cities_name', @f.build_select(*args)
      args = [UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor']
      assert_equal 'articles.title AS articles_title, journals.name AS journals_name, countries.name AS countries_name, user_articles.ismainauthor AS user_articles_ismainauthor', @f.build_select(*args)
    end

    def test_set_tables
      args = [UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor']
      assert_equal 'user_articles, articles, journals, countries', @f.set_tables(*args).join(', ')
      args = [UserArticle, ['article', 'title', ['journal', 'name']], 'ismainauthor']
      assert_equal 'user_articles, articles, journals', @f.set_tables(*args).join(', ')
      args = [UserArticle, 'ismainauthor']
      assert_equal 'user_articles', @f.set_tables(*args).join(', ')
   end

   def  test_build_conditions
     args =[UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor']
     assert_equal 'user_articles.article_id = articles.id  AND articles.journal_id = journals.id  AND journals.country_id = countries.id ', @f.build_conditions(*args).join(' AND ')
   end

  def test_sql
    assert_equal "    SELECT user_articles.id AS id, articles.title AS articles_title, journals.name AS journals_name\n    FROM user_articles, articles, journals\n    WHERE user_articles.article_id = articles.id  AND articles.journal_id = journals.id \n", @f.sql
  end

  def test_as_text
    assert_equal ['Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS', 'Estudio de barrancos en Marte, QUO'],  @f.as_text
  end

  def test_as_pair
    assert_equal [['Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS', 1],  ['Estudio de barrancos en Marte, QUO', 2]],  @f.as_pair
  end

  def test_as_text
    assert_equal [ ['user_article', 'Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS'], ['user_article','Estudio de barrancos en Marte, QUO']],  @f.as_hash
  end
end
