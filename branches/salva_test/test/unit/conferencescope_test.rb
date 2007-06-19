require File.dirname(__FILE__) + '/../test_helper'
require 'conferencescope'

class ConferencescopeTest < Test::Unit::TestCase
  fixtures :conferencescopes
  include UnitSimple

  def setup
    @conferencescopes = %w(nacional internacional)
    @myconferencescope = Conferencescope.new({:name => 'Otro', :id => 10})
  end

  # Right - CRUD
   def test_crud 
     crud_test(@conferencescopes, Conferencescope)
   end

   def test_validation
     validate_test(@conferencescopes, Conferencescope)
   end

   def test_collision
     collision_test(@conferencescopes, Conferencescope)
   end

   def test_create_with_empty_attributes
     @conferencescope = Conferencescope.new
     assert !@conferencescope.save
   end

   ######################
   # Boundary 
   #
   ######################
   def test_bad_values_for_id
     # Float number for ID 
     @myconferencescope.id = 1.6
     assert !@myconferencescope.valid?
   end

   def test_bad_values_for_name
     @myconferencescope.name = nil
     assert !@myconferencescope.valid?
   end
end

