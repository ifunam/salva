require File.dirname(__FILE__) + '/../test_helper'
require 'edition'

class EditionTest < Test::Unit::TestCase
  fixtures :editions
  include UnitSimple

  def setup
    @editions = %w(primera segunda tercera)
    @myedition = Edition.new({:name => 'Cuarta'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@editions, Edition)
  end

  def test_validation
    validate_test(@editions, Edition)
  end

  def test_collision
    collision_test(@editions, Edition)
  end

  def test_creating_with_empty_attributes
    @edition = Edition.new
    assert !@edition.save
  end

  def test_uniqueness
    @edition = Edition.new({:name => 'Primera'})
    @edition.id = 1
    assert !@edition.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myedition.id = 'xx'
    assert !@myedition.valid?

    # Negative number ID
    #@myedition.id = -1
    #assert !@myedition.valid?

    # Float number ID
    @myedition.id = 1.3
    assert !@myedition.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myedition = Edition.new
    @myedition.name = nil
    assert !@myedition.valid?
  end
end
