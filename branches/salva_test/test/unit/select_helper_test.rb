require File.dirname(__FILE__) + '/../test_helper'
require 'select_helper'
class SelectHelperTest < Test::Unit::TestCase
  include SelectHelper
  fixtures :userstatuses, :users, :maritalstatuses, :countries, :states, :cities, :people, :languages, :mediatypes, :publishers, :journals, :articlestatuses, :articles, :user_articles
    
  def test_should_selectize_id_from_object
    record = Person.find_by_firstname('Juana')
    selected_id = selectize_id(record, 'country_id')
    assert_equal 484, selected_id
  end

  def test_should_set_default_value_for_fieldid_in_a_new_object
    record = Person.new
    record.country_id = selectize_id(record, 'country_id', 500)
    assert_equal 500, record.country_id
  end

  def test_not_should_set_default_value_for_unexistent_fieldid_from_object
    record = Person.new
    record.country_id = selectize_id(record, 'country_id2')
    assert_equal nil, record.country_id
  end

  def test_should_selectize_id_from_filter
    record = Person.find_by_firstname('Juana')
    assert_equal 25, record.state_id
    filter = { 'state_id' => 19}
    record.state_id = selectize_id(record, 'state_id', 9, filter)
    assert_equal 19, record.state_id
  end
  
  def test_finder_id
    assert_equal [['México', 484]], finder_id(Country, 484)
    assert_equal [['Sinaloa', 25]], finder_id(State, 25)
    assert_equal [['Mexicana', 484]], finder_id(Country, 484, 'citizen')
    assert_equal [["Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS",1]], finder_id(UserArticle, 1, ['article', 'title', ['journal', 'name']])
  end

  def test_simple_select
    @edit  = UserLanguage.new
    #puts simple_select('edit', Language, 1)
  end
end
