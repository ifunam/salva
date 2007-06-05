 
require File.dirname(__FILE__) + '/../test_helper'
require 'booktype'

class BooktypeTest < Test::Unit::TestCase
  fixtures :booktypes

  def setup
    @booktypes = %w(coleccion serie arbitrado)
    @mybooktype = Booktype.new({:name => 'Enciclopedia'})
  end
  
  # Right - CRUD
  def test_creating_booktypes_from_yaml
    @booktypes.each { | booktype|
      @booktype = Booktype.find(booktypes(booktype.to_sym).id)
      assert_kind_of Booktype, @booktype
      assert_equal booktypes(booktype.to_sym).id, @booktype.id
      assert_equal booktypes(booktype.to_sym).name, @booktype.name
    }
  end
  
  def test_updating_booktypes_name
    @booktypes.each { |booktype|
      @booktype = Booktype.find(booktypes(booktype.to_sym).id)
      assert_equal booktypes(booktype.to_sym).name, @booktype.name
      @booktype.name = @booktype.name.chars.reverse 
      assert @booktype.update
      assert_not_equal booktypes(booktype.to_sym).name, @booktype.name
    }
  end  

  def test_deleting_booktypes
    @booktypes.each { |booktype|
      @booktype = Booktype.find(booktypes(booktype.to_sym).id)
      @booktype.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Country.find(booktypes(booktype.to_sym).id) 
      }
    }
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

   ######################
   # Boundary 
   #
  def test_bad_values_for_id
    # Non numeric ID 
    @mybooktype.id = 'xx'
    assert !@mybooktype.valid?

    @mybooktype.id = -1
    assert !@mybooktype.valid?
  end
  
  def test_bad_values_for_name
    @mybooktype.name = nil
    assert !@mybooktype.valid?

    @mybooktype.name = ''
    assert !@mybooktype.valid?

    @mybooktype.name = 'X' * 251
    assert !@mybooktype.valid?
  end
end

