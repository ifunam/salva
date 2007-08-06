require File.dirname(__FILE__) + '/../test_helper'
require 'bookchaptertype'

class BookchaptertypeTest < Test::Unit::TestCase
  fixtures :bookchaptertypes
  include UnitSimple

  def setup
    @bookchaptertype = %w(prologo prefacio introduccion)
    @mybookchaptertype = Bookchaptertype.new({:name => 'Apéndice'})
  end

  #Right - CRUD
  def test_crud
    crud_test(@bookchaptertype, Bookchaptertype)
  end

  def test_validation
    validate_test(@bookchaptertype, Bookchaptertype)
  end

  def test_collision
    collision_test(@bookchaptertype, Bookchaptertype)
  end

  def test_create_with_empty_attributes
    @bookchaptertype = Bookchaptertype.new
    assert !@bookchaptertype.save
  end

  def test_check_uniqueness
    @bookchaptertype = Bookchaptertype.new({:name => 'Introducción'})
    assert !@bookchaptertype.save
  end
  # boundary
  # Checking constraints for name
  def test_bad_values_for_name
    @mybookchaptertype.name = nil
    assert !@mybookchaptertype.valid?
  end

  # Checking constraints for ID
  def test_bad_values_for_id

    @mybookchaptertype.id = 'xx'
    assert !@mybookchaptertype.valid?

    @mybookchaptertype.id = 3.1416
    assert !@mybookchaptertype.valid?

    #     @mybookchaptertype.id = -7
    #     assert !@mybookchaptertype.valid?
  end

end
