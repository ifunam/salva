require File.dirname(__FILE__) + '/../test_helper'
require 'publicationcategory'

class PublicationcategoryTest < Test::Unit::TestCase
  fixtures :publicationcategories
  include UnitSimple
  def setup
    @publicationcategories = %w(acoustics agricultural_economics_&_policy agricultural_engineering)
    @mypublicationcategory = Publicationcategory.new({:name => 'Acustico'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@publicationcategories, Publicationcategory)
  end

  def test_validation
    validate_test(@publicationcategories, Publicationcategory)
  end

  def test_collision
    collision_test(@publicationcategories, Publicationcategory)
  end

  def test_uniqueness
    @publicationcategory = Publicationcategory.new({:name => 'Agricultural Economics & Policy'})
    assert !@publicationcategory.save
  end

  def test_empty_object
    @publicationcategory = Publicationcategory.new()
    assert !@publicationcategory.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mypublicationcategory.id = 'xx'
    assert !@mypublicationcategory.valid?

    # Negative number ID
    # @mypublicationcategory.id = -1
    # assert !@mypublicationcategory.valid?

    # Float number ID
    @mypublicationcategory.id = 1.3
    assert !@mypublicationcategory.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mypublicationcategory = Publicationcategory.new
    @mypublicationcategory.name = nil
    assert !@mypublicationcategory.valid?
  end
end
