require File.dirname(__FILE__) + '/../test_helper'
require 'studentrole'

class StudentroleTest < Test::Unit::TestCase
  fixtures :studentroles
  include UnitSimple

  def setup
    @studentroles = %w(becario servicio tesista)
  end

  # Right - CRUD

  def test_crud
    crud_test(@studentroles, Studentrole)
  end

  def test_validation
    validate_test(@studentroles, Studentrole)
  end

  def test_collision
    collision_test(@studentroles, Studentrole)
  end

  def test_create_with_empty_attributes
    @mystudentrole = Studentrole.new
    assert !@mystudentrole.save
  end

  def test_check_uniqueness
    @mystudentrole2 = Studentrole.new({:name => 'Tesista'})
    assert !@mystudentrole2.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mystudentrole = Studentrole.new
    @mystudentrole.id = 'xx'
    assert !@mystudentrole.valid?

    # Negative number ID
    #@mystudentrole.id = -1
    #assert !@mystudentrole.valid?

    # Float number ID
    @mystudentrole.id = 1.3
    assert !@mystudentrole.valid?

    # Nil number ID
    @mystudentrole.id = nil
    assert !@mystudentrole.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mystudentrole = Studentrole.new
    @mystudentrole.name = nil
    assert !@mystudentrole.valid?
  end
end
