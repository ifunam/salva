require File.dirname(__FILE__) + '/../test_helper'
require 'techproductstatus'

class TechproductstatusTest < Test::Unit::TestCase
  fixtures :techproductstatuses
  include UnitSimple

  def setup
    @techproductstatuses = %w(otro entregado en_desarrollo)
    @mytechproductstatus = Techproductstatus.new({:name => 'Pendiente'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@techproductstatuses, Techproductstatus)
  end

  def test_validation
    validate_test(@techproductstatuses, Techproductstatus)
  end

  def test_collision
    collision_test(@techproductstatuses, Techproductstatus)
  end

  def test_create_with_empty_attributes
    @mytechproductstatus = Techproductstatus.new
    assert !@mytechproductstatus.save
  end

  def test_check_uniqueness
    @myrtechproductstatus = Techproductstatus.new({:name => 'Entregado'})
    assert !@myrtechproductstatus.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mytechproductstatus = Techproductstatus.new
    @mytechproductstatus.id = 'xx'
    assert !@mytechproductstatus.valid?

    # Negative number ID
    #@mytechproductstatus.id = -1
    #assert !@myrtechproductstatus.valid?

    # Float number ID
    @mytechproductstatus.id = 1.3
    assert !@mytechproductstatus.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mytechproductstatus = Techproductstatus.new
    @mytechproductstatus.name = nil
    assert !@mytechproductstatus.valid?
  end
end
