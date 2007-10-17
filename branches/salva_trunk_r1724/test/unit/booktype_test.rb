require File.dirname(__FILE__) + '/../test_helper'
require 'booktype'

class BooktypeTest < Test::Unit::TestCase
  fixtures :booktypes
  include UnitSimple

  def setup
    @booktypes = %w(coleccion serie arbitrado)
    @mybooktype = Booktype.new({:name => 'Enciclopedia'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@booktypes, Booktype)
  end

  def test_validation
    validate_test(@booktypes, Booktype)
  end

  def test_collision
    collision_test(@booktypes, Booktype)
  end

  def test_creating_with_empty_attributes
    @booktype = Booktype.new
    assert !@booktype.save
  end

  def test_uniqueness
    @booktype = Booktype.new({:name => 'Serie'})
    @booktype.id = 2
    assert !@booktype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mybooktype.id = 'xx'
    assert !@mybooktype.valid?

    # Negative number ID
    #@mybooktype.id = -1
    #assert !@mybooktype.valid?

    # Float number ID
    @mybooktype.id = 1.3
    assert !@mybooktype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mybooktype = Booktype.new
    @mybooktype.name = nil
    assert !@mybooktype.valid?
  end
end

