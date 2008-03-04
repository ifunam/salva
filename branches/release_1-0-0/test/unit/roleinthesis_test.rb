require File.dirname(__FILE__) + '/../test_helper'
require 'roleinthesis'

class RoleinthesisTest < Test::Unit::TestCase
  fixtures :roleintheses
  include UnitSimple

  def setup
    @roleintheses = %w(autor director asesor)
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleintheses, Roleinthesis)
  end

  def test_validation
    validate_test(@roleintheses, Roleinthesis)
  end

  def test_collision
    collision_test(@roleintheses, Roleinthesis)
  end

  def test_create_with_empty_attributes
    @myroleinthesis = Roleinthesis.new
    assert !@myroleinthesis.save
  end

  def test_check_uniqueness
    @myroleinthesis2 = Roleinthesis.new({:name => 'Autor'})
    assert !@myroleinthesis2.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinthesis = Roleinthesis.new
    @myroleinthesis.id = 'xx'
    assert !@myroleinthesis.valid?

    # Negative number ID
    #@myroleinthesis.id = -1
    #assert !@myroleinthesis.valid?

    # Float number ID
    @myroleinthesis.id = 1.3
    assert !@myroleinthesis.valid?

    # Very large number for ID
    @myroleinthesis.id = 10000
    assert !@myroleinthesis.valid?

    # Nil number ID
    @myroleinthesis.id = nil
    assert !@myroleinthesis.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinthesis = Roleinthesis.new
    @myroleinthesis.name = nil
    assert !@myroleinthesis.valid?
  end

end
