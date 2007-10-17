require File.dirname(__FILE__) + '/../test_helper'
require 'userrole'

class UserroleTest < Test::Unit::TestCase
  fixtures :userroles
  include UnitSimple

  def setup
    @userroles = %w(autor coautor revisor)
  end

  # Right - CRUD
  def test_crud
    crud_test(@userroles, Userrole)
  end

  def test_validation
    validate_test(@userroles, Userrole)
  end

  def test_collision
    collision_test(@userroles, Userrole)
  end

  def test_create_with_empty_attributes
    @myuserrole = Userrole.new
    assert !@myuserrole.save
  end

  def test_check_uniqueness
    @myuserrole2 = Userrole.new({:name => 'Autor'})
    assert !@myuserrole2.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myuserrole = Userrole.new
    @myuserrole.id = 'xx'
    assert !@myuserrole.valid?

    # Negative number ID
    #@myuserrole.id = -1
    #assert !@myuserrole.valid?

    # Float number ID
    @myuserrole.id = 1.3
    assert !@myuserrole.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myuserrole = Userrole.new
    @myuserrole.name = nil
    assert !@myuserrole.valid?
  end
end
