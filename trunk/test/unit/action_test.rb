require File.dirname(__FILE__) + '/../test_helper'
require 'action'

class ActionTest < Test::Unit::TestCase
  fixtures :actions
  include UnitSimple
  def setup
    @actions = %w(new list index)
    @myaction = Action.new({:name => 'edit'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@actions, Action)
  end

  def test_validation
    validate_test(@actions, Action)
  end

  def test_collision
    collision_test(@actions, Action)
  end

  def test_uniqueness
    @action = Action.new({:name => 'list'})
    assert !@action.save
  end

  def test_empty_object
    @action = Action.new()
    assert !@action.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myaction.id = 'xx'
    assert !@myaction.valid?

    # Negative number ID
    #@myaction.id = -1
    #assert !@myaction.valid?

    # Float number ID
    @myaction.id = 1.3
    assert !@myaction.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myaction = Action.new
    @myaction.name = nil
    assert !@myaction.valid?
  end
end
