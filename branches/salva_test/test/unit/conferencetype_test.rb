require File.dirname(__FILE__) + '/../test_helper'
require 'conferencetype'

class ConferencetypeTest < Test::Unit::TestCase
  fixtures :conferencetypes
  include UnitSimple

  def setup
    @conferencetypes = %w(congreso coloquio)
    @myconferencetype = Conferencetype.new({:name => 'Otro', :id => 10})
  end

  # Right - CRUD
   def test_crud 
     crud_test(@conferencetypes, Conferencetype)
   end

   def test_validation
     validate_test(@conferencetypes, Conferencetype)
   end

   def test_collision
     collision_test(@conferencetypes, Conferencetype)
   end

   def test_create_with_empty_attributes
     @conferencetype = Conferencetype.new
     assert !@conferencetype.save
   end

   ######################
   # Boundary 
   #
   ######################
   def test_bad_values_for_id
     # Float number for ID 
     @myconferencetype.id = 1.6
     assert !@myconferencetype.valid?

     # Negative numbers
     @myconferencetype.id = nil
     assert !@myconferencetype.valid?
   end

   def test_bad_values_for_name
     @myconferencetype.name = nil
     assert !@myconferencetype.valid?

     @myconferencetype.name = 'AB' 
     assert !@myconferencetype.valid?

     @myconferencetype.name = 'AB' * 800
     assert !@myconferencetype.valid?
   end
end

