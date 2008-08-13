require File.dirname(__FILE__) + '/../test_helper'
require 'talktype'

class TalktypeTest < Test::Unit::TestCase
  fixtures :talktypes
  include UnitSimple
  def setup
    @talktypes = %w(conferencia_magistral platica ponencia)
    @mytalktype = Talktype.new({:name => 'Tutorial'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@talktypes, Talktype)
  end

  def test_validation
    validate_test(@talktypes, Talktype)
  end

  def test_collision
    collision_test(@talktypes, Talktype)
  end

  def test_uniqueness
    @talktype = Talktype.new({:name => 'Plática'})
    assert !@talktype.save
  end

  def test_empty_object
    @talktype = Talktype.new()
    assert !@talktype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mytalktype.id = 'xx'
    assert !@mytalktype.valid?

    # Negative number ID
    # @mytalktype.id = -1
    # assert !@mytalktype.valid?

    # Float number ID
    @mytalktype.id = 1.3
    assert !@mytalktype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mytalktype = Talktype.new
    @mytalktype.name = nil
    assert !@mytalktype.valid?
  end
end
