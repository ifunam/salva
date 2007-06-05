require File.dirname(__FILE__) + '/../test_helper'
require 'edition'

class EditionTest < Test::Unit::TestCase
  fixtures :editions

  def setup
    @editions = %w(primera segunda tercera)
    @myedition = Edition.new({:name => 'Cuarta'})
  end
  
  # Right - CRUD
  def test_creating_editions_from_yaml
    @editions.each { | edition|
      @edition = Edition.find(editions(edition.to_sym).id)
      assert_kind_of Edition, @edition
      assert_equal editions(edition.to_sym).id, @edition.id
      assert_equal editions(edition.to_sym).name, @edition.name
    }
  end
  
  def test_updating_editions
    @editions.each { |edition|
      @edition = Edition.find(editions(edition.to_sym).id)
      assert_equal editions(edition.to_sym).name, @edition.name
      @edition.name = @edition.name.chars.reverse 
      assert @edition.update
      assert_not_equal editions(edition.to_sym).name, @edition.name
    }
  end  

  def test_deleting_editions
    @editions.each { |edition|
      @edition = Edition.find(editions(edition.to_sym).id)
      @edition.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Edition.find(editions(edition.to_sym).id) 
      }
    }
  end 

  def test_creating_with_empty_attributes
    @edition = Edition.new
    assert !@edition.save
  end

  def test_uniqueness
    @edition = Edition.new({:name => 'Primera'})
    @edition.id = 1
    assert !@edition.save
  end

  #########################
  # Boundary
  def test_bad_values_for_id
    # Non numeric ID 
    @myedition.id = 'xx'
    assert !@myedition.valid?

    # Nil ID 
    @myedition.id = nil
    assert !@myedition.valid?
    # Negative number ID 

    @myedition.id = -1
    assert !@myedition.valid?
  end

  def test_bad_values_for_name
    # Nil name
    @myedition.name = nil
    assert !@myedition.valid?
  end
end
