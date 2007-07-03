require File.dirname(__FILE__) + '/../test_helper'
require 'language'

class LanguageTest < Test::Unit::TestCase
  fixtures :languages
  include UnitSimple

  def setup
    @languages= %w(portugues ingles espanol)
    @mylanguage = Language.new({:name => 'Chino'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@languages, Language)
  end

  def test_validation
    validate_test(@languages, Language)
  end

  def test_collision
    collision_test(@languages, Language)
  end

  def test_create_with_empty_attributes
    @language = Language.new
    assert !@language.save
  end

  #validates uniqueness
  def test_uniqueness
    @language = Language.new({:name => 'Inglés'})
    @language.id = 2
    assert !@language.save
  end

  # Boundary
  def test_bad_values_for_name
    @mylanguage.name = nil
    assert !@mylanguage.valid?
  end

  # Checking constraints for ID
  def test_bad_values_for_id
    @mylanguage.id = 'xx'
    assert !@mylanguage.valid?

    @mylanguage.id = 3.1416
    assert !@mylanguage.valid?

    #@mylanguage.id = -7
    #assert !@mylanguage.valid?
  end
end

