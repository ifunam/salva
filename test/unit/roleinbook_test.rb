require File.dirname(__FILE__) + '/../test_helper'
require 'roleinbook'

class RoleinbookTest < Test::Unit::TestCase
  fixtures :roleinbooks
  include UnitSimple

  def setup
    @roleinbooks = %w(autor coautor revisor)
    @myroleinbook = Roleinbook.new({:name => 'Editor'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinbooks, Roleinbook)
  end

  def test_validation
    validate_test(@roleinbooks, Roleinbook)
  end

  def test_collision
    collision_test(@roleinbooks, Roleinbook)
  end

  def test_create_with_empty_attributes
    @myroleinbook = Roleinbook.new
    assert !@myroleinbook.save
  end

  def test_check_uniqueness
    @myroleinbook = Roleinbook.new({:name => 'Autor'})
    assert !@myroleinbook.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinbook = Roleinbook.new
    @myroleinbook.id = 'xx'
    assert !@myroleinbook.valid?

    # Negative number ID
    #@myroleinbook.id = -1
    #assert !@myroleinbook.valid?

    # Float number ID
    @myroleinbook.id = 1.3
    assert !@myroleinbook.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinbook = Roleinbook.new
    @myroleinbook.name = nil
    assert !@myroleinbook.valid?
  end
end
