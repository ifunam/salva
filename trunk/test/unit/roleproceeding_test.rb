require File.dirname(__FILE__) + '/../test_helper'
require 'roleproceeding'

class RoleproceedingTest < Test::Unit::TestCase
  fixtures :roleproceedings
  include UnitSimple

  def setup
    @roleproceedings = %w(arbitro editor compilador)
  end
  
  # Right - CRUD  
   def test_crud 
     crud_test(@roleproceedings, Roleproceeding)
   end

   def test_validation
     validate_test(@roleproceedings, Roleproceeding)
   end

   def test_collision
     collision_test(@roleproceedings, Roleproceeding)
   end

   def test_create_with_empty_attributes
     @myroleproceeding = Roleproceeding.new
     assert !@myroleproceeding.save
   end

   def test_check_uniqueness
     @myroleproceeding = Roleproceeding.new({:name => 'Arbitro'})
     assert !@myroleproceeding.save
   end

   # Boundaries
   def test_bad_values_for_id
    @myroleproceeding = Roleproceeding.new
    @myroleproceeding.id = 'xx'
    assert !@myroleproceeding.valid?

    # Negative number ID 
    #@mycredential.id = -1
    #assert !@mycredential.valid?

    # Float number ID 
    @myroleproceeding.id = 1.3
    assert !@myroleproceeding.valid?

    # Very large number for ID }
    @myroleproceeding.id = 2
    rango = 1..3
    assert rango.include?(@myroleproceeding.id) 

    # Nil number ID 
    @myroleproceeding.id = nil
    assert !@myroleproceeding.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    @myroleproceeding = Roleproceeding.new
    @myroleproceeding.name = nil
    assert !@myroleproceeding.valid?
  end
 
end
