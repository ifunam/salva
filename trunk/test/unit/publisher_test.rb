require File.dirname(__FILE__) + '/../test_helper'
require 'publisher'

class PublisherTest < Test::Unit::TestCase
  fixtures :publishers
  include UnitSimple

  def setup
    @publisher = %w(ak_peters balkema adasi)
    @mypublisher = Publisher.new({:name => 'Barks Publications'})
	
  end

  def test_crud 
    crud_test(@publisher, Publisher)
  end

  def test_validation
    validate_test(@publisher, Publisher)
  end

  def test_collision
    collision_test(@publisher, Publisher)
  end
 def test_create_with_empty_attributes
     @publisher = Publisher.new
     assert !@publisher.save
   end

   
   #validates uniqueness
   def test_uniqueness
     @publisher = Publisher.new({:name => 'A K Peters Ltd'})
     @publisher.id = 1
     assert !@publisher.save
   end

   
   # Boundary   #
   
   
   # Checking constraints for name
   def test_bad_values_for_name
     @mypublisher.name = nil
     assert !@mypublisher.valid?

     @mypublisher.name = 'X'
     assert !@mypublisher.valid?

     @mypublisher.name = 'X' * 201
     assert !@mypublisher.valid?

     @mypublisher.name = '5' 
     assert !@mypublisher.valid?
  end
   
   # Checking constraints for ID
   def test_bad_values_for_id
     @mypublisher.id = 'xx'
     assert !@mypublisher.valid?

     @mypublisher.id = nil
     assert !@mypublisher.valid?

     @mypublisher.id = 3.1416
     assert !@mypublisher.valid?
  end

end
