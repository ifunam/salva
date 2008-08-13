require File.dirname(__FILE__) + '/../test_helper'
require 'talkacceptance'

class TalkacceptanceTest < Test::Unit::TestCase
  fixtures :talkacceptances
  include UnitSimple
  def setup
    @talkacceptances = %w(arbitrado invitacion inscripcion)
    @mytalkacceptance = Talkacceptance.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@talkacceptances, Talkacceptance)
  end

  def test_validation
    validate_test(@talkacceptances, Talkacceptance)
  end

  def test_collision
    collision_test(@talkacceptances, Talkacceptance)
  end

  def test_uniqueness
    @talkacceptance = Talkacceptance.new({:name => 'Invitación'})
    assert !@talkacceptance.save
  end

  def test_empty_object
    @talkacceptance = Talkacceptance.new()
    assert !@talkacceptance.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mytalkacceptance.id = 'xx'
    assert !@mytalkacceptance.valid?

    # Negative number ID
    #@mytalkacceptance.id = -1
    #assert !@mytalkacceptance.valid?

    # Float number ID
    @mytalkacceptance.id = 1.3
    assert !@mytalkacceptance.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mytalkacceptance = Talkacceptance.new
    @mytalkacceptance.name = nil
    assert !@mytalkacceptance.valid?
  end
end
