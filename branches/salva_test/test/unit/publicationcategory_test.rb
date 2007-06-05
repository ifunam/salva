require File.dirname(__FILE__) + '/../test_helper'
require 'publicationcategory'

class PublicationcategoryTest < Test::Unit::TestCase
  fixtures :publicationcategories 
  def setup
    @publicationcategories = %w(acoustics agricultural_economics_&_policy agricultural_engineering)
    @mypublicationcategory = Publicationcategory.new({:name => 'Acustico'})
  end
  
  # Right - CRUD
  def test_creating_from_yaml
    @publicationcategories.each { |publicationcategory|
      @publicationcategory = Publicationcategory.find(publicationcategories(publicationcategory.to_sym).id)
      assert_kind_of Publicationcategory, @publicationcategory
      assert_equal publicationcategories(publicationcategory.to_sym).id,   @publicationcategory.id
      assert_equal publicationcategories(publicationcategory.to_sym).name, @publicationcategory.name
    }
  end
  
  def test_updating_name
    @publicationcategories.each { |publicationcategory|
      @publicationcategory = Publicationcategory.find(publicationcategories(publicationcategory.to_sym).id)
      assert_equal publicationcategories(publicationcategory.to_sym).name, @publicationcategory.name
      @publicationcategory.name = @publicationcategory.name.chars.reverse 
      assert @publicationcategory.update
      assert_not_equal publicationcategories(publicationcategory.to_sym).name, @publicationcategory.name
    }
  end  

  def test_deleting
    @publicationcategories.each { |publicationcategory|
      @publicationcategory = Publicationcategory.find(publicationcategories(publicationcategory.to_sym).id)
      @publicationcategory.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Publicationcategory.find(publicationcategories(publicationcategory.to_sym).id)
      }
    }
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
