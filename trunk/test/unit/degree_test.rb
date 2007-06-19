require File.dirname(__FILE__) + '/../test_helper'
require 'degree'

class DegreeTest < Test::Unit::TestCase
  fixtures :degrees

  def setup
    @degrees = %w(maestria licenciatura)
    @mydegree = Degree.new({:name => 'PHD', :id => 6})
  end
  
  # Right - CRUD
  def test_creating_degrees_from_yaml
    @degrees.each { | degree|
      @degree = Degree.find(degrees(degree.to_sym).id)
      assert_kind_of Degree, @degree
      assert_equal degrees(degree.to_sym).id, @degree.id
      assert_equal degrees(degree.to_sym).name, @degree.name
     }
  end
  
  def test_updating
    @degrees.each { |degree|
      @degree = Degree.find(degrees(degree.to_sym).id)
      assert_equal degrees(degree.to_sym).name, @degree.name
      @degree.name = @degree.name.chars.reverse 
      assert @degree.update
      assert_not_equal degrees(degree.to_sym).name, @degree.name
    }
  end  

  def test_deleting
    @degrees.each { |degree|
      @degree = Degree.find(degrees(degree.to_sym).id)
      @degree.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Degree.find(degrees(degree.to_sym).id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @degree = Degree.new
     assert !@degree.save
   end

   def test_uniqueness
     @degree = Degree.new({:name => 'Licenciatura'})
     assert !@degree.save
   end

   #Boundary
   def test_bad_values_for_id
     # Float number for ID 
     @mydegree.id = 1.6
     assert !@mydegree.valid?

     # Negative numbers
     #@mydegree.id = -1
     #assert !@mydegree.valid?

     @mydegree.id = 'mi_id_txt'
     assert !@mydegree.valid?
   end

   def test_bad_values_for_name
     @mydegree.name = nil
     assert !@mydegree.valid?
   end
end

