require File.dirname(__FILE__) + '/../test_helper'
require 'roleincourse'

class RoleincourseTest < Test::Unit::TestCase
  fixtures :roleincourses
  include UnitSimple

  def setup
    @roleincourses = %w(instructor autor asistente)
    @myroleincourse = Roleincourse.new({:name => 'Adjunto'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleincourses, Roleincourse)
  end

  def test_validation
    validate_test(@roleincourses, Roleincourse)
  end

  def test_collision
    collision_test(@roleincourses, Roleincourse)
  end

  def test_create_with_empty_attributes
    @myroleincourse = Roleincourse.new
    assert !@myroleincourse.save
  end

  def test_check_uniqueness
    @myroleincourse = Roleincourse.new({:name => 'Asistente'})
    assert !@myroleincourse.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleincourse = Roleincourse.new
    @myroleincourse.id = 'xx'
    assert !@myroleincourse.valid?

    # Negative number ID
    @myroleincourse.id = -1
    assert !@myroleincourse.valid?

    # Float number ID
    @myroleincourse.id = 1.3
    assert !@myroleincourse.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleincourse = Roleincourse.new
    @myroleincourse.name = nil
    assert !@myroleincourse.valid?
  end
end
