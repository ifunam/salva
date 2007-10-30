require File.dirname(__FILE__) + '/../test_helper'
require 'roleinchapter'

class RoleinchapterTest < Test::Unit::TestCase
  fixtures :roleinchapters
  include UnitSimple

  def setup
    @roleinchapters = %w(autor coautor revisor)
    @myroleinchapter = Roleinchapter.new({:name => 'Traductor'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinchapters, Roleinchapter)
  end

  def test_validation
    validate_test(@roleinchapters, Roleinchapter)
  end

  def test_collision
    collision_test(@roleinchapters, Roleinchapter)
  end

  def test_create_with_empty_attributes
    @myroleinchapter = Roleinchapter.new
    assert !@myroleinchapter.save
  end

  def test_check_uniqueness
    @myroleinchapter = Roleinchapter.new({:name => 'Autor'})
    assert !@myroleinchapter.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinchapter = Roleinchapter.new
    @myroleinchapter.id = 'xx'
    assert !@myroleinchapter.valid?

    # Negative number ID
    @myroleinchapter.id = -1
    assert !@myroleinchapter.valid?

    # Float number ID
    @myroleinchapter.id = 1.3
    assert !@myroleinchapter.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinchapter = Roleinchapter.new
    @myroleinchapter.name = nil
    assert !@myroleinchapter.valid?
  end
end
