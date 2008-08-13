require File.dirname(__FILE__) + '/../test_helper'
require 'techproducttype'

class TechproducttypeTest < Test::Unit::TestCase
  fixtures :techproducttypes
  include UnitSimple

  def setup
    @techproducttype = %w(videos spots carteles)
    @mytechproducttype = Techproducttype.new({:name => 'Diaporamas'})
  end

  #Right - CRUD
  def test_crud
    crud_test(@techproducttype, Techproducttype)
  end

  def test_validation
    validate_test(@techproducttype, Techproducttype)
  end

  def test_collision
    collision_test(@techproducttype, Techproducttype)
  end

  def test_create_with_empty_attributes
    @techproducttype = Techproducttype.new
    assert !@techproducttype.save
  end

  def test_check_uniqueness
    @techproducttype = Techproducttype.new({:name => 'Spots'})
    assert !@techproducttype.save
  end
  # boundary
  # Checking constraints for name
  def test_bad_values_for_name
    @mytechproducttype.name = nil
    assert !@mytechproducttype.valid?
  end

  # Checking constraints for ID
  def test_bad_values_for_id
    @mytechproducttype.id = 'xx'
    assert !@mytechproducttype.valid?

    @mytechproducttype.id = 3.1416
    assert !@mytechproducttype.valid?

    #@mytechproducttype.id = -7
    #assert !@mytechproducttype.valid?
  end

end
