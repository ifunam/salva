require File.dirname(__FILE__) + '/../test_helper'
require 'role'

class RoleTest < Test::Unit::TestCase
  fixtures :roles
  include UnitSimple

  def setup
    @roles = %w(administrador salva)
    @myrole = Role.new({:name => 'Jefe'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roles, Role)
  end

  def test_validation
    validate_test(@roles, Role)
  end

  def test_collision
    collision_test(@roles, Role)
  end

  def test_create_with_empty_attributes
    @myrole = Role.new
    assert !@myrole.save
  end

  def test_check_uniqueness
    @myrole = Role.new({:name => 'Salva'})
    assert !@myrole.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myrole = Role.new
    @myrole.id = 'xx'
    assert !@myrole.valid?

    # Negative number ID
    #@myrole.id = -1
    #assert !@myrole.valid?

    # Float number ID
    @myrole.id = 1.3
    assert !@myrole.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myrole = Role.new
    @myrole.name = nil
    assert !@myrole.valid?
  end

  def test_bad_values_for_has_group_right
    @myrole = Role.new
    @myrole.has_group_right = "texto"
    assert !@myrole.valid?
  end
end
