require File.dirname(__FILE__) + '/../test_helper'
require 'projectstatus'

class ProjectstatusTest < Test::Unit::TestCase
  fixtures :projectstatuses
  include UnitSimple

  def setup
    @projectstatuses = %w(concluido inicio)
    @myprojectstatus = Projectstatus.new({:name => 'En proceso'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@projectstatuses, Projectstatus)
  end

  def test_validation
    validate_test(@projectstatuses, Projectstatus)
  end

  def test_collision
    collision_test(@projectstatuses, Projectstatus)
  end

  def test_create_with_empty_attributes
    @myprojectstatus= Projectstatus.new
    assert !@myprojectstatus.save
  end

  def test_check_uniqueness
    @myprojectstatus = Projectstatus.new({:name => 'Inicio'})
    assert !@myprojectstatus.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myprojectstatus = Projectstatus.new
    @myprojectstatus.id = 'xx'
    assert !@myprojectstatus.valid?

    # Negative number ID
    #@myprojectstatus.id = -1
    #assert !@myprojectstatus.valid?

    # Float number ID
    @myprojectstatus.id = 1.3
    assert !@myprojectstatus.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    @myprojectstatus= Projectstatus.new
    @myprojectstatus.name = nil
    assert !@myprojectstatus.valid?
  end

end
