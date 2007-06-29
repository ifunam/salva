require File.dirname(__FILE__) + '/../test_helper'
require 'roleinregularcourse'

class RoleinregularcourseTest < Test::Unit::TestCase
  fixtures :roleinregularcourses
  include UnitSimple
  def setup
    @roleinregularcourses = %w(titular ayudante)
    @myroleinregularcourse = Roleinregularcourse.new({:name => 'Apoyo'})
  end

  #Right - CRUD
  def test_crud
    crud_test(@roleinregularcourses, Roleinregularcourse)
  end

  def test_validation
    validate_test(@roleinregularcourses, Roleinregularcourse)
  end

  def test_collision
    collision_test(@roleinregularcourses, Roleinregularcourse)
  end

  def test_uniqueness
    @roleinregularcourses = Roleinregularcourse.new({:name => 'Titular'})
    assert !@roleinregularcourses.save
  end

  def test_empty_object
    @roleinregularcourses = Roleinregularcourse.new()
    assert !@roleinregularcourses.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinregularcourse.id = 'xx'
    assert !@myroleinregularcourse.valid?

    # Negative number ID
    # @myroleinregularcourse.id = -1
    # assert !@myroleinregularcourse.valid?

    # Float number ID
    @myroleinregularcourse.id = 1.3
    assert !@myroleinregularcourse.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinregularcourse = Roleinregularcourse.new
    @myroleinregularcourse.name = nil
    assert !@myroleinregularcourse.valid?
  end
end
