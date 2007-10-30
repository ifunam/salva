require File.dirname(__FILE__) + '/../test_helper'
require 'finder'
class FinderTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :maritalstatuses, :countries, :states, :cities,
    :people, :addresstypes, :addresses, :languages, :languagelevels, :mediatypes,
    :publishers, :journals, :articlestatuses, :articles, :user_articles, :roleintheses,
    :conferencetypes, :conferencescopes, :conferences, :proceedings, :migratorystatuses,
    :citizenmodalities, :citizens, :idtypes, :identifications, :jobpositionlevels,
    :roleinjobpositions, :jobpositiontypes, :jobpositioncategories, :institutiontitles,
    :institutiontypes, :institutions

  def setup
    @user_article_finder  = Finder.new(UserArticle, :all, :attributes => ['ismainauthor', ['article', 'title', ['journal', 'name']] ])
    @country_finder  = Finder.new(Country)
    @article_finder  = Finder.new(Article)
    @user_article_simple  = Finder.new(UserArticle)
    @country_finder_first = Finder.new(Country, :first)
   end

  def test_initialize
    assert_instance_of Finder, Finder.new(UserArticle, :attributes => [['article', 'title', ['journal', 'name']]])
    assert_instance_of Finder, Finder.new(UserArticle, :all, :attributes => [['article', 'title', ['journal', 'name']]])
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
    args = ['article', 'title', 'year', 'month']
    assert_equal "articles.title AS articles_title, articles.year AS articles_year, articles.month AS articles_month", @user_article_finder.build_select(*args)
    args = ['article', 'title', ['journal', 'name', ['country', 'name']], 'year', 'month']
    assert_equal "articles.title AS articles_title, journals.name AS journals_name, countries.name AS countries_name, articles.year AS articles_year, articles.month AS articles_month", @user_article_finder.build_select(*args)
    args = [UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor']
    assert_equal "articles.title AS articles_title, journals.name AS journals_name, countries.name AS countries_name, user_articles.ismainauthor AS user_articles_ismainauthor", @user_article_finder.build_select(*args)
  end

  def test_set_tables
    args = [[UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor' ]]
    assert_equal ["user_articles", "articles", "journals", "countries"], @user_article_finder.set_tables(*args)
    args = [[UserArticle, [['article', 'title', ['journal', 'name']], 'ismainauthor']]]
    assert_equal ['user_articles', 'articles', 'journals'], @user_article_finder.set_tables(*args)
    args = [[UserArticle, 'ismainauthor']]
    assert_equal ['user_articles'], @user_article_finder.set_tables(*args)
    args=  [[Citizen, ['idtype', 'citizen_country', 'citizenmodality', 'migratorystatus']]]
  end

  def test_set_table_array
    args = [['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor' ]
    assert_equal ["articles", "journals", "countries"], @user_article_finder.set_table_array(*args)
    args = [['article', 'title', ['journal', 'name']], 'ismainauthor']
    assert_equal ["articles", "journals"], @user_article_finder.set_tables(*args)
    args = ['ismainauthor']
    assert_equal [], @user_article_finder.set_tables(*args)
  end

  def  test_build_conditions
    args = [UserArticle, ['article', 'title', ['journal', 'name', ['country', 'name']]], 'ismainauthor']
    assert_equal 'user_articles.article_id = articles.id  AND articles.journal_id = journals.id  AND journals.country_id = countries.id ', @user_article_finder.build_conditions(*args).join(' AND ')
  end

  def test_sql
    assert_equal "SELECT user_articles.id AS id, user_articles.ismainauthor AS user_articles_ismainauthor, articles.title AS articles_title, journals.name AS journals_name FROM user_articles, articles, journals WHERE user_articles.article_id = articles.id AND articles.journal_id = journals.id", @user_article_finder.sql
    @f = Finder.new(Roleingroup, :attributes =>[ 'group', 'role' ] )
    assert_equal "SELECT roleingroups.id AS id, groups.name AS groups_name, roles.name AS roles_name FROM roleingroups, groups, roles WHERE roleingroups.group_id = groups.id AND roleingroups.role_id = roles.id", @f.sql
    @f = Finder.new(Seminary, :attributes =>%w(title year isseminary))
    assert_equal "SELECT seminaries.id AS id, seminaries.title AS seminaries_title, seminaries.year AS seminaries_year, seminaries.isseminary AS seminaries_isseminary FROM seminaries", @f.sql
  end

  def test_as_text
    assert_equal ["Autor principal, Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS", "Autor principal, Estudio de barrancos en Marte, QUO"],  @user_article_finder.as_text
  end

  def test_as_pair
    assert_equal [["Autor principal, Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS", 1], ["Autor principal, Estudio de barrancos en Marte, QUO", 2]],  @user_article_finder.as_pair
  end

  def test_as_hash
    assert_equal [["user_article", "Autor principal, Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS"], ["user_article", "Autor principal, Estudio de barrancos en Marte, QUO"]],  @user_article_finder.as_hash
  end

  def test_set_attributes
    assert_equal ['name'], @country_finder.set_attributes(Country)
    assert_equal ['title'], @article_finder.set_attributes(Article)
    assert_equal ["article_id", "ismainauthor", "other"],  @user_article_simple.set_attributes(UserArticle)
    assert_equal [["article", "title"], "ismainauthor", "other"],  @user_article_simple.set_attributes(UserArticle, true)
    assert_equal ['name'], @country_finder_first.set_attributes(Country)
  end

  def test_simple_sql
    assert_equal "SELECT id, name FROM countries ORDER BY name ASC",  @country_finder.sql
    assert_equal "SELECT id, title FROM articles ORDER BY title ASC", @article_finder.sql
    assert_equal "SELECT id, article_id, ismainauthor, other FROM user_articles ORDER BY article_id, ismainauthor, other ASC", @user_article_simple.sql
    assert_equal "SELECT id, name FROM countries ORDER BY name ASC LIMIT 1",  @country_finder_first.sql
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

  def test_sql_with_complex_conditions
    @f = Finder.new(Addresstype, :conditions => "addresstypes.id NOT IN (SELECT addresstypes.id FROM addresstypes, addresses WHERE addresses.addresstype_id = addresstypes.id AND addresses.user_id = 2)")
    assert_equal "SELECT id, name FROM addresstypes WHERE addresstypes.id NOT IN (SELECT addresstypes.id FROM addresstypes, addresses WHERE addresses.addresstype_id = addresstypes.id AND addresses.user_id = 2) ORDER BY name ASC", @f.sql

    @f = Finder.new(Proceeding,  :attributes => %w(title year), :conditions => "isrefereed = 'f'" )
    assert_equal "SELECT proceedings.id AS id, proceedings.title AS proceedings_title, proceedings.year AS proceedings_year FROM proceedings WHERE isrefereed = 'f'", @f.sql
    assert_equal [["Coloquio de Artes Manuales y otras habilidades", 2], ["Characterización of position-sensitive photomultiplier tubesfor microPET, detection modules", 1]], @f.as_pair

    @f = Finder.new(Roleinthesis, :attributes => %w(name),  :conditions => "name = 'Director' OR name = 'Asesor' OR name = 'Lector'")
    assert_equal "SELECT roleintheses.id AS id, roleintheses.name AS roleintheses_name FROM roleintheses WHERE name = 'Director' OR name = 'Asesor' OR name = 'Lector'", @f.sql

    @f = Finder.new(Jobposition,  :attributes => ['jobpositioncategory'], :conditions => "institutions.institution_id = 1 AND jobpositions.institution_id = institutions.id AND jobpositions.user_id = 2", :include => [:institutions])
    assert_equal "SELECT jobpositions.id AS id, jobpositiontypes.name AS jobpositiontypes_name, roleinjobpositions.name AS roleinjobpositions_name, jobpositionlevels.name AS jobpositionlevels_name, jobpositioncategories.administrative_key AS jobpositioncategories_administrative_key FROM jobpositions, jobpositioncategories, jobpositiontypes, roleinjobpositions, jobpositionlevels, institutions WHERE jobpositions.jobpositioncategory_id = jobpositioncategories.id AND jobpositioncategories.jobpositiontype_id = jobpositiontypes.id AND jobpositioncategories.roleinjobposition_id = roleinjobpositions.id AND jobpositioncategories.jobpositionlevel_id = jobpositionlevels.id AND institutions.institution_id = 1 AND jobpositions.institution_id = institutions.id AND jobpositions.user_id = 2", @f.sql

    @f = Finder.new(Jobposition,  :attributes => [['jobpositioncategory', ['jobpositiontype', 'name'], ['roleinjobposition', 'name'], ['jobpositionlevel', 'name']] ], :conditions => "institutions.institution_id = 1 AND jobpositions.institution_id = institutions.id AND jobpositions.user_id = 2", :include => [:institutions])
    assert_equal "SELECT jobpositions.id AS id, jobpositiontypes.name AS jobpositiontypes_name, roleinjobpositions.name AS roleinjobpositions_name, jobpositionlevels.name AS jobpositionlevels_name FROM jobpositions, jobpositioncategories, jobpositiontypes, roleinjobpositions, jobpositionlevels, institutions WHERE jobpositions.jobpositioncategory_id = jobpositioncategories.id AND jobpositioncategories.jobpositiontype_id = jobpositiontypes.id AND jobpositioncategories.roleinjobposition_id = roleinjobpositions.id AND jobpositioncategories.jobpositionlevel_id = jobpositionlevels.id AND institutions.institution_id = 1 AND jobpositions.institution_id = institutions.id AND jobpositions.user_id = 2", @f.sql

    @f = Finder.new(Jobposition,  :attributes => [['jobpositioncategory', 'jobpositiontype',  'roleinjobposition',  'jobpositionlevel'] ], :conditions => "institutions.institution_id = 1 AND jobpositions.institution_id = institutions.id AND jobpositions.user_id = 2", :include => [:institutions])
    assert_equal "SELECT jobpositions.id AS id, jobpositiontypes.name AS jobpositiontypes_name, roleinjobpositions.name AS roleinjobpositions_name, jobpositionlevels.name AS jobpositionlevels_name FROM jobpositions, jobpositioncategories, jobpositiontypes, roleinjobpositions, jobpositionlevels, institutions WHERE jobpositions.jobpositioncategory_id = jobpositioncategories.id AND jobpositioncategories.jobpositiontype_id = jobpositiontypes.id AND jobpositioncategories.roleinjobposition_id = roleinjobpositions.id AND jobpositioncategories.jobpositionlevel_id = jobpositionlevels.id AND institutions.institution_id = 1 AND jobpositions.institution_id = institutions.id AND jobpositions.user_id = 2", @f.sql

    @f = Finder.new(Jobpositioncategory, :attributes => [ 'roleinjobposition', 'jobpositionlevel'] , :conditions => "jobpositiontype_id = 2")
    assert_equal "SELECT jobpositioncategories.id AS id, roleinjobpositions.name AS roleinjobpositions_name, jobpositionlevels.name AS jobpositionlevels_name FROM jobpositioncategories, roleinjobpositions, jobpositionlevels WHERE jobpositioncategories.roleinjobposition_id = roleinjobpositions.id AND jobpositioncategories.jobpositionlevel_id = jobpositionlevels.id AND jobpositiontype_id = 2", @f.sql
    assert_equal ["Técnico académico, Asoc. A  M.T."], @f.as_text

    @f = Finder.new(Institution, :attributes => ['name', ['institution', 'abbrev']], :conditions => "institutions.institution_id = 1")
     assert_equal "SELECT institutions.id AS id, institutions.name AS institutions_name, prefix_for_parent_institutions.abbrev AS prefix_for_parent_institutions_abbrev FROM institutions, institutions AS prefix_for_parent_institutions WHERE institutions.institution_id = prefix_for_parent_institutions.id AND institutions.institution_id = 1", @f.sql

    @f = Finder.new( Identification, :attributes =>['idtype',  ['citizen_country', 'citizen']],  :conditions => "identifications.id IN (SELECT identifications.id FROM identifications, citizens WHERE citizens.citizen_country_id = identifications.citizen_country_id AND citizens.user_id = 2 AND identifications.id NOT IN (SELECT identifications.id FROM identifications, people_identifications WHERE people_identifications.user_id = 2 AND people_identifications.identification_id = identifications.id))" )
    assert_equal "SELECT identifications.id AS id, idtypes.name AS idtypes_name, citizen_countries.citizen AS citizen_countries_citizen FROM identifications, idtypes, countries AS citizen_countries WHERE identifications.idtype_id = idtypes.id AND identifications.citizen_country_id = citizen_countries.id AND identifications.id IN (SELECT identifications.id FROM identifications, citizens WHERE citizens.citizen_country_id = identifications.citizen_country_id AND citizens.user_id = 2 AND identifications.id NOT IN (SELECT identifications.id FROM identifications, people_identifications WHERE people_identifications.user_id = 2 AND people_identifications.identification_id = identifications.id))", @f.sql

    @f = Finder.new(Institutioncareer, :attributes => [['institution', 'name', ['institution', 'abbrev'] ], ['career', 'degree', 'name']], :conditions => "institutions.institutiontitle_id = 3 AND institutioncareers.institution_id = institutions.id")
    assert_equal "SELECT institutioncareers.id AS id, institutions.name AS institutions_name, prefix_for_parent_institutions.abbrev AS prefix_for_parent_institutions_abbrev, degrees.name AS degrees_name, careers.name AS careers_name FROM institutioncareers, institutions, institutions AS prefix_for_parent_institutions, careers, degrees WHERE institutioncareers.institution_id = institutions.id AND institutions.institution_id = prefix_for_parent_institutions.id AND institutioncareers.career_id = careers.id AND careers.degree_id = degrees.id AND institutions.institutiontitle_id = 3 AND institutioncareers.institution_id = institutions.id", @f.sql

    @f = Finder.new(Academicprogram, :attributes => [['institutioncareer', 'career', ['institution', ['institution', 'abbrev']]], 'year', 'academicprogramtype'])
    assert_equal "SELECT academicprograms.id AS id, careers.name AS careers_name, prefix_for_parent_institutions.abbrev AS prefix_for_parent_institutions_abbrev, academicprograms.year AS academicprograms_year, academicprogramtypes.name AS academicprogramtypes_name FROM academicprograms, institutioncareers, careers, institutions, institutions AS prefix_for_parent_institutions, academicprogramtypes WHERE academicprograms.institutioncareer_id = institutioncareers.id AND institutioncareers.career_id = careers.id AND institutioncareers.institution_id = institutions.id AND institutions.institution_id = prefix_for_parent_institutions.id AND academicprograms.academicprogramtype_id = academicprogramtypes.id", @f.sql

    @f = Finder.new(Institutioncareer, :attributes => [ ['career', 'degree', 'name'], ['institution', 'name']], :conditions => "institutioncareers.career_id = careers.id AND careers.degree_id = 3 AND institutioncareers.institution_id = institutions.id AND institutions.country_id != 484")

    assert_equal 'SELECT institutioncareers.id AS id, degrees.name AS degrees_name, careers.name AS careers_name, institutions.name AS institutions_name FROM institutioncareers, careers, degrees, institutions WHERE institutioncareers.career_id = careers.id AND careers.degree_id = degrees.id AND institutioncareers.institution_id = institutions.id AND institutioncareers.career_id = careers.id AND careers.degree_id = 3 AND institutioncareers.institution_id = institutions.id AND institutions.country_id != 484', @f.sql

    @f = Finder.new(Institutioncareer, :attributes => [ ['career', 'degree', 'name'], ['institution', 'name', ['institution', 'abbrev']]], :conditions => "institutioncareers.career_id = careers.id AND careers.degree_id = 3 AND institutioncareers.institution_id = institutions.id AND institutions.country_id = 484 AND institutions.institution_id != 1", :order => 'careers.name ASC' )
    assert_equal "SELECT institutioncareers.id AS id, degrees.name AS degrees_name, careers.name AS careers_name, institutions.name AS institutions_name, prefix_for_parent_institutions.abbrev AS prefix_for_parent_institutions_abbrev FROM institutioncareers, careers, degrees, institutions, institutions AS prefix_for_parent_institutions WHERE institutioncareers.career_id = careers.id AND careers.degree_id = degrees.id AND institutioncareers.institution_id = institutions.id AND institutions.institution_id = prefix_for_parent_institutions.id AND institutioncareers.career_id = careers.id AND careers.degree_id = 3 AND institutioncareers.institution_id = institutions.id AND institutions.country_id = 484 AND institutions.institution_id != 1 ORDER BY careers.name ASC", @f.sql
  end
  
  def test_as_collection
    @country_finder.as_collection.collect { |record|
      assert_instance_of Country, record
    }
  end
end
