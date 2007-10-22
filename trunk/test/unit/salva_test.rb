require File.dirname(__FILE__) + '/../test_helper'
require RAILS_ROOT + '/lib/salva'

class TestSalva < Test::Unit::TestCase
  include Salva
  fixtures [:countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions]

  def test_get_cfg
    # Error Arguments
    assert_raises (ArgumentError) { get_cfg}
    assert_raises (ArgumentError) { get_cfg('a','b') }

    #Right
    assert_equal 'Instituto de Física - UNAM', get_cfg('institution')
    assert_equal 'http://www.fisica.unam.mx', get_cfg('institution_url')
    #assert_equal 314, get_cfg('administrative_key')
    assert_equal 'default', get_cfg('theme')
    assert_equal 14, get_cfg('most_common_school')

    #Undefined conf
    assert_equal "unexistent no esta definido en #{RAILS_ROOT}/config/site.yml", get_cfg('unexistent')

    #Bad Values
    if (get_cfg('administrative_key')-5000) < 0 then
      x = true
    else
      x = false
    end
    assert_equal true, x
  end

  def test_get_myinstitution
    #Error Arguments
    assert_raises (ArgumentError) { get_myinstitution('a', 'b') }

    #Right
    assert_instance_of Institution, get_myinstitution
    assert_kind_of Institution, get_myinstitution
    assert_equal '314', get_myinstitution.administrative_key
    assert_equal 'Instituto de Fisica', get_myinstitution.name
    assert_not_nil get_myinstitution

    #Error Klass
    assert_not_equal User, get_myinstitution

    #Bad Values
    assert_not_equal '200', get_myinstitution.administrative_key
    assert_not_equal 'Intituto de Geologia', get_myinstitution.name
  end

  def test_get_myschool
    # Error Arguments
    assert_raises (ArgumentError) { get_myschool('a', 'b') }

    # Right
    assert_instance_of Institution, get_myschool
    assert_kind_of Institution, get_myschool
    assert_equal 14, get_myschool.id
    assert_equal 'Facultad de Ciencias', get_myschool.name
    assert_not_nil get_myschool

    #Error Klass
    assert_not_equal User, get_myinstitution

    #Bad Values
    assert_not_equal '200', get_myschool.administrative_key
    assert_not_equal 'Intituto de Geologia', get_myschool.name
    assert_not_equal 40, get_myschool.id
  end
end
