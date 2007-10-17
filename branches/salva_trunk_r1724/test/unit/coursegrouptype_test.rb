require File.dirname(__FILE__) + '/../test_helper'
require 'coursegrouptype'

class CoursegrouptypeTest < Test::Unit::TestCase
  fixtures :coursegrouptypes
  include UnitSimple

  def setup
    @coursegrouptypes = %w(actualizacion diplomado )
    @mycoursegrouptype = Coursegrouptype.new
  end

  # Right - CRUD
  def test_crud
    crud_test(@coursegrouptypes, Coursegrouptype)
  end

  def test_validation
    validate_test(@coursegrouptypes, Coursegrouptype)
  end

  def test_collision
    collision_test(@coursegrouptypes, Coursegrouptype)
  end

  def test_create_with_empty_attributes
    @mycoursegrouptype = Coursegrouptype.new
    assert !@mycoursegrouptype.save
  end

  def test_check_uniqueness
    @mycoursegrouptype2 = Coursegrouptype.new({:name => 'Certificación'})
    assert !@mycoursegrouptype2.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mycoursegrouptype.id = 'xx'
    assert !@mycoursegrouptype.valid?

    # Negative number ID
    #@mycoursegrouptype.id = -1
    #assert !@mycoursegrouptype.valid?

    # Float number ID
    @mycoursegrouptype.id = 1.3
    assert !@mycoursegrouptype.valid?

    # Nil number ID
    @mycoursegrouptype.id = nil
    assert !@mycoursegrouptype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mycoursegrouptype.name = nil
    assert !@mycoursegrouptype.valid?
  end

end
