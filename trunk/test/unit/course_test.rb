require File.dirname(__FILE__) + '/../test_helper'
require 'course'

class CourseTest < Test::Unit::TestCase
  fixtures :coursedurations, :modalities, :countries, :courses

  def setup
    @courses = %w(linux matematicas)
    @mycourse = Course.new({:name => 'Computación', :courseduration_id => 3, :modality_id =>1, :country_id => 484, :startyear => 2007})
  end
  
  # Right - CRUD
  def test_creating_courses_from_yaml
    @courses.each { | course|
      @course = Course.find(courses(course.to_sym).id)
      assert_kind_of Course, @course
      assert_equal courses(course.to_sym).id, @course.id
      assert_equal courses(course.to_sym).name, @course.name
      assert_equal courses(course.to_sym).courseduration_id, @course.courseduration_id
      assert_equal courses(course.to_sym).modality_id, @course.modality_id
    }
  end
  
  def test_updating_courses_name
    @courses.each { |course|
      @course = Course.find(courses(course.to_sym).id)
      assert_equal courses(course.to_sym).name, @course.name
      @course.name = @course.name.chars.reverse 
      assert @course.update
      assert_not_equal courses(course.to_sym).name, @course.name
    }
  end  

  def test_deleting_courses
    @courses.each { |course|
      @course = Course.find(courses(course.to_sym).id)
      @course.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Course.find(courses(course.to_sym).id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @course = Course.new
     assert !@course.save
   end

   def test_creating_duplicated_course
     @course = Course.new(({:name => 'Linux', :courseduration_id => 3, :modality_id =>1, :country_id => 484, :startyear => 2007}))
     @course.id = 1
     assert !@course.save
   end

     # Boundary 
   def test_bad_values_for_id
     # Float number for ID 
     @mycourse.id = 1.6
     assert !@mycourse.valid?

    # Negative numbers
     @mycourse.id = -1
     assert !@mycourse.valid?
   end

   def test_bad_values_for_name
     @mycourse.name = nil
     assert !@mycourse.valid?
   end

   def test_bad_values_for_country_id
     # Checking constraints for name
     # Nil name
     @mycourse.country_id = nil
     assert !@mycourse.valid?

     # Float number for ID 
     @mycourse.country_id = 3.1416
     assert !@mycourse.valid?

    # Negative numbers
     @mycourse.country_id = -1
     assert !@mycourse.valid?
   end
 

   def test_bad_values_for_modality_id
     # Checking constraints for name
     # Nil name
     @mycourse.modality_id = nil
     assert !@mycourse.valid?

     # Float number for ID 
     @mycourse.modality_id = 3.1416
     assert !@mycourse.valid?

    # Negative numbers
     @mycourse.modality_id = -1
     assert !@mycourse.valid?
   end
 

   def test_bad_values_for_courseduration_id
     # Checking constraints for name
     # Nil name
     @mycourse.courseduration_id = nil
     assert !@mycourse.valid?

     # Float number for ID 
     @mycourse.courseduration_id = 3.1416
     assert !@mycourse.valid?

    # Negative numbers
     @mycourse.courseduration_id = -1
     assert !@mycourse.valid?
   end
 



  #Cross-Checking test 
 def test_cross_checking_for_courseduration_id
   @courses.each { | course|
      @course = Course.find(courses(course.to_sym).id)
      assert_kind_of Course, @course
      assert_equal @course.courseduration_id, Courseduration.find(@course.courseduration_id).id 
    }
 end 

def test_cross_checking_with_bad_values_for_courseduration_id
   @courses.each { | course|
     @course = Course.find(courses(course.to_sym).id)
     assert_kind_of Course, @course
     @course.courseduration_id = 108
     begin 
            return true if @course.update
     rescue StandardError => x
            return false
     end
   }
 end

 def test_cross_checking_for_country_id
   @courses.each { | course|
      @course = Course.find(courses(course.to_sym).id)
      assert_kind_of Course, @course
      assert_equal @course.country_id, Country.find(@course.country_id).id 
    }
 end 

def test_cross_checking_with_bad_values_for_country_id
   @courses.each { | course|
     @course = Course.find(courses(course.to_sym).id)
     assert_kind_of Course, @course
     @course.country_id = 108
     begin 
            return true if @course.update
     rescue StandardError => x
            return false
     end
   }
 end


 def test_cross_checking_for_Modality_id
   @courses.each { | course|
      @course = Course.find(courses(course.to_sym).id)
      assert_kind_of Course, @course
      assert_equal @course.modality_id, Modality.find(@course.modality_id).id 
    }
 end 

def test_cross_checking_with_bad_values_for_Modality_id
   @courses.each { | course|
     @course = Course.find(courses(course.to_sym).id)
     assert_kind_of Course, @course
     @course.modality_id = 108
     begin 
            return true if @course.update
     rescue StandardError => x
            return false
     end
   }
 end


end

