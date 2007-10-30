require File.dirname(__FILE__) + '/../test_helper'
require 'migratorystatus'

class MigratorystatusTest < Test::Unit::TestCase
  fixtures :migratorystatuses
  include UnitSimple
  def setup
    @migratorystatuses = %w(turista residente_temporal residente_permanente)
    @mymigratorystatus = Migratorystatus.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@migratorystatuses, Migratorystatus)
  end

  def test_validation
    validate_test(@migratorystatuses, Migratorystatus)
  end

  def test_collision
    collision_test(@migratorystatuses, Migratorystatus)
  end

  def test_uniqueness
    @migratorystatus = Migratorystatus.new({:name => 'Residente temporal'})
    assert !@migratorystatus.save
  end

  def test_empty_object
    @migratorystatus = Migratorystatus.new()
    assert !@migratorystatus.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mymigratorystatus.id = 'xx'
    assert !@mymigratorystatus.valid?

    # Negative number ID
    @mymigratorystatus.id = -1
    assert !@mymigratorystatus.valid?

    # Float number ID
    @mymigratorystatus.id = 1.3
    assert !@mymigratorystatus.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mymigratorystatus = Migratorystatus.new
    @mymigratorystatus.name = nil
    assert !@mymigratorystatus.valid?
  end
end
