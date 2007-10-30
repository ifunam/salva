require File.dirname(__FILE__) + '/../test_helper'
require 'jobpositionlevel'

class JobpositionlevelTest < Test::Unit::TestCase
  fixtures :jobpositionlevels
  include UnitSimple

  def setup
    @jobpositionlevels = %w(asoc._a__m.t. asoc._a__t.c. asoc._a_m.t.)
    @myjobpositionlevel = Jobpositionlevel.new({:name => 'Aux. A M.T.'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@jobpositionlevels, Jobpositionlevel)
  end

  def test_validation
    validate_test(@jobpositionlevels, Jobpositionlevel)
  end

  def test_collision
    collision_test(@jobpositionlevels, Jobpositionlevel)
  end

  def test_create_with_empty_attributes
    @myjobpositionlevel = Jobpositionlevel.new
    assert !@myjobpositionlevel.save
  end

  def test_check_uniqueness
    @myjobpositionlevel = Jobpositionlevel.new({:name => 'Asoc. A M.T.'})
    assert !@myjobpositionlevel.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myjobpositionlevel = Jobpositionlevel.new
    @myjobpositionlevel.id = 'xx'
    assert !@myjobpositionlevel.valid?

    @myjobpositionlevel.id = -1
    assert !@myjobpositionlevel.valid?

    # Float number ID
    @myjobpositionlevel.id = 1.3
    assert !@myjobpositionlevel.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myjobpositionlevel = Jobpositionlevel.new
    @myjobpositionlevel.name = nil
    assert !@myjobpositionlevel.valid?
  end
end
