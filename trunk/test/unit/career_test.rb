require File.dirname(__FILE__) + '/../test_helper'
require 'career'

class CareerTest < Test::Unit::TestCase
  fixtures :careers

  def setup
    @careers = %w(actuaria administración)
  end
  
  # Right - CRUD
  def test_creating_careers_from_yaml
    @careers.each { | career|
      @career = Career.find(careers(career.to_sym).id)
      assert_kind_of Career, @career
      assert_equal careers(career.to_sym).id, @career.id
      assert_equal careers(career.to_sym).name, @career.name
      assert_equal careers(career.to_sym).degree_id, @career.degree_id
    }
  end
  
  def test_updating_careers_name
    @careers.each { |career|
      @career = Career.find(careers(career.to_sym).id)
      assert_equal careers(career.to_sym).name, @career.name
      @career.name = @career.name.chars.reverse 
      assert @career.update
      assert_not_equal careers(career.to_sym).name, @career.name
    }
  end  

  def test_deleting_careers
    @careers.each { |career|
      @career = Career.find(careers(career.to_sym).id)
      @career.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Career.find(careers(career.to_sym).id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @career = Career.new
     assert !@career.save
   end

   def test_creating_duplicated_career
     @career = Career.new({:name => 'Actuaria', :degree_id => 3})
     @career.id = 1
     assert !@career.save
   end

   # Boundary
   def test_validating_careers_with_bad_values

     # Checking constraints for DEGREE_ID
     @career = Career.new({:name => 'Actuaria', :degree_id => 3})

     # Negative number ID 
     @career.id = -9
     assert !@career.valid?

     # Float number for ID 
     @career.id = 1.6
     assert !@career.valid?

     # Checking constraints for name
     # Nil name
     @career.name = nil
     assert !@career.valid?
   end

   # Put here the Unit testing for the foreing key models..
   # ...
end

