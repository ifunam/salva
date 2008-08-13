 require File.dirname(__FILE__) + '/../test_helper'
require 'application_helper'
class ApplicationHelperTest < Test::Unit::TestCase
  include ApplicationHelper
  fixtures :userstatuses, :users,  :maritalstatuses, :countries, :states, :cities, :people, :languages

  def test_foreignizing_model
    assert_equal 'country_id', foreignize(Country)
    assert_equal 'orig_language_id', foreignize(Language, 'orig')
  end

end
