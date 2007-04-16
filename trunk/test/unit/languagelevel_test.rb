require File.dirname(__FILE__) + '/../test_helper'
require 'languagelevel'

class LanguagelevelTest < Test::Unit::TestCase
  fixtures :languagelevels
  include UnitSimple
  
  def setup
    @languagelevels = %w(basico intermedio avanzado)
    @mylanguagelevel = Languagelevel.new({:name => 'superavanzado'})
  end
  
  # Right - CRUD
  def test_crud 
    crud_test(@languagelevels, Languagelevel)
  end
  
  def test_validation
    validate_test(@languagelevels, Languagelevel)
  end
  
  def test_collision
    collision_test(@languagelevels, Languagelevel)
  end
  
  def test_creating_languagelevel_with_empty_attributes
    @languagelevel = Languagelevel.new
    assert !@languagelevel.save
  end
  
  def test_uniqueness
    @languagelevel = Languagelevel.new({:name => 'Avanzado'})
    assert !@languagelevel.save
  end

  def test_bad_values_for_id
    #Negative number 
    @mylanguagelevel.id = -5
    assert !@mylanguagelevel.valid?

    #Negative number ID 
    @mylanguagelevel.id= 1.8
    assert !@mylanguagelevel.valid?
  end   

  def test_bad_values_for_name
    @mylanguagelevel.name = nil
    assert !@mylanguagelevel.valid?

    @mylanguagelevel.name = ''
    assert !@mylanguagelevel.valid?

    @mylanguagelevel.name = 'K' * 101
    assert !@mylanguagelevel.valid?
  end
end

