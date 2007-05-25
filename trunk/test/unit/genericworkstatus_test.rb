require File.dirname(__FILE__) + '/../test_helper'
require 'genericworkstatus'

class GenericworkstatusTest < Test::Unit::TestCase
  fixtures :genericworkstatuses
  include UnitSimple
  
  def setup
    @genericworkstatuss = %w(aceptado propuesto enviado)
    @mygenericworkstatuss = Genericworkstatus.new({:name => 'semienviado'})
  end

   #Right - CRUD
   def test_crud 
     crud_test(@genericworkstatuss, Genericworkstatus)
   end

   def test_validation
     validate_test(@genericworkstatuss, Genericworkstatus)
   end

   def test_collision
     collision_test(@genericworkstatuss, Genericworkstatus)
   end

   def test_create_with_empty_attributes
     @genericworkstatuss = Genericworkstatus.new
     assert !@genericworkstatuss.save
   end

   def test_check_uniqueness
     @genericworkstatuss = Genericworkstatus.new({:name => 'Aceptado'})
     @genericworkstatuss.id= 3
     assert !@genericworkstatuss.save
   end
# boundary
# Checking constraints for name
  def test_bad_values_for_name
     @mygenericworkstatuss.name = nil
     assert !@mygenericworkstatuss.valid?

     @mygenericworkstatuss.name = 'X'
     assert !@mygenericworkstatuss.valid?

     @mygenericworkstatuss.name = 'X' * 201
     assert !@mygenericworkstatuss.valid?

     @mygenericworkstatuss.name = '5' 
     assert !@mygenericworkstatuss.valid?
  end
   
   # Checking constraints for ID
   def test_bad_values_for_id
     @mygenericworkstatuss.id = 'xx'
     assert !@mygenericworkstatuss.valid?

     @mygenericworkstatuss.id = nil
     assert !@mygenericworkstatuss.valid?

     #@mygenericworkstatuss.id = -10
     #assert !@mygenericworkstatuss.valid?


     @mygenericworkstatuss.id = 3.1416
     assert !@mygenericworkstatuss.valid?
  end

	end
