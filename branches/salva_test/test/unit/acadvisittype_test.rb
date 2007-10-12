require File.dirname(__FILE__) + '/../test_helper'
require 'acadvisittype'

class AcadvisittypeTest < Test::Unit::TestCase
  fixtures :acadvisittypes
  include UnitSimple

  def setup
    @acadvisittypes = %w(posdoctoral sabatico investigacion)
    @myacadvisittype = Acadvisittype.new({:name => 'entrevistas'})
  end

  #Right - CRUD
  def test_crud
    crud_test(@acadvisittypes, Acadvisittype)
  end

  def test_validation
    validate_test(@acadvisittypes, Acadvisittype)
  end

  def test_collision
    collision_test(@acadvisittypes, Acadvisittype)
  end

  def test_create_with_empty_attributes
    @acadvisittypes = Acadvisittype.new
    assert !@acadvisittypes.save
  end

  def test_check_uniqueness
    @acadvisittypes = Acadvisittype.new({:name => 'Posdoctoral'})
    assert !@acadvisittypes.save
  end
  # boundary
  # Checking constraints for name
  def test_bad_values_for_name
    @myacadvisittype.name = nil
    assert !@myacadvisittype.valid?
  end

  # Checking constraints for ID
  def test_bad_values_for_id
    @myacadvisittype.id = 'xx'
    assert !@myacadvisittype.valid?

    @myacadvisittype.id = -3.0
    assert !@myacadvisittype.valid?

    @myacadvisittype.id = 3.1416
    assert !@myacadvisittype.valid?
  end

end
