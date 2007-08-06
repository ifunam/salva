require File.dirname(__FILE__) + '/../test_helper'
require 'roleinjournal'

class RoleinjournalTest < Test::Unit::TestCase
  fixtures :roleinjournals
  include UnitSimple
  def setup
    @roleinjournals = %w(compilador editor revisor)
    @myroleinjournal = Roleinjournal.new({:name => 'Arbitro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinjournals, Roleinjournal)
  end

  def test_validation
    validate_test(@roleinjournals, Roleinjournal)
  end

  def test_collision
    collision_test(@roleinjournals, Roleinjournal)
  end

  def test_uniqueness
    @roleinjournal = Roleinjournal.new({:name => 'Compilador'})
    assert !@roleinjournal.save
  end

  def test_empty_object
    @roleinjournal = Roleinjournal.new()
    assert !@roleinjournal.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinjournal.id = 'xx'
    assert !@myroleinjournal.valid?

    # Negative number ID
    #@myroleinjournal.id = -1
    #assert !@myroleinjournal.valid?

    # Float number ID
    @myroleinjournal.id = 1.3
    assert !@myroleinjournal.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinjournal = Roleinjournal.new
    @myroleinjournal.name = nil
    assert !@myroleinjournal.valid?
  end
end
