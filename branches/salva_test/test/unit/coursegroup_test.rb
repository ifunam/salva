require File.dirname(__FILE__) + '/../test_helper'
require 'coursegroup'

class CoursegroupTest < Test::Unit::TestCase
  fixtures :coursegrouptypes,:coursegroups


  def setup
    @coursegroups = %w(lentos medios ñoño)
    @mycoursegroup = Coursegroup.new({:name => 'nivel1', :coursegrouptype_id => 3, :startyear => 2007})
  end
  
  # Right - CRUD
  def test_creating_coursegroups_from_yaml
    @coursegroups.each { | coursegroup|
      @coursegroup = Coursegroup.find(coursegroups(coursegroup.to_sym).id)
      assert_kind_of Coursegroup, @coursegroup
      assert_equal coursegroups(coursegroup.to_sym).id, @coursegroup.id
      assert_equal coursegroups(coursegroup.to_sym).name, @coursegroup.name
      assert_equal coursegroups(coursegroup.to_sym).coursegrouptype_id, @coursegroup.coursegrouptype_id
      assert_equal coursegroups(coursegroup.to_sym).startyear, @coursegroup.startyear
    }
  end
  
  def test_updating_coursegroups_name
    @coursegroups.each { |coursegroup|
      @coursegroup = Coursegroup.find(coursegroups(coursegroup.to_sym).id)
      assert_equal coursegroups(coursegroup.to_sym).name, @coursegroup.name
      @coursegroup.name = @coursegroup.name.chars.reverse * 2
      assert @coursegroup.update
      assert_not_equal coursegroups(coursegroup.to_sym).name, @coursegroup.name
    }
  end  

  def test_deleting_coursegroups
    @coursegroups.each { |coursegroup|
      @coursegroup = Coursegroup.find(coursegroups(coursegroup.to_sym).id)
      @coursegroup.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Coursegroup.find(coursegroups(coursegroup.to_sym).id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @coursegroup = Coursegroup.new
     assert !@coursegroup.save
   end

   def test_creating_duplicated_coursegroup
     @coursegroup = Coursegroup.new({:name => 'nerd', :coursegrouptype_id => 3, :startyear => 2007})
     @coursegroup.id = 2
     assert !@coursegroup.save
   end


     # Boundary 
   def test_bad_values_for_id
     # Float number for ID 
     @mycoursegroup.id = 1.6
     assert !@mycoursegroup.valid?

    # Negative numbers
    # @mycoursegroup.id = -1
    # assert !@mycoursegroup.valid?
   end


   def test_bad_values_for_name
     @mycoursegroup.name = nil
     assert !@mycoursegroup.valid?
   end

   def test_bad_values_for_coursegrouptype_id
     # Checking constraints for name
     # Nil name
     @mycoursegroup.coursegrouptype_id = nil
     assert !@mycoursegroup.valid?

     # Float number for ID 
     @mycoursegroup.coursegrouptype_id = 3.1416
     assert !@mycoursegroup.valid?

    # Negative numbers
    # @mycoursegroup.coursegrouptype_id = -1
    # assert !@mycoursegroup.valid?
   end



  #Cross-Checking test 


 def test_cross_checking_for_coursegrouptype_id
   @coursegroups.each { | coursegroup|
      @coursegroup = Coursegroup.find(coursegroups(coursegroup.to_sym).id)
      assert_kind_of Coursegroup, @coursegroup
      assert_equal @coursegroup.coursegrouptype_id, Coursegrouptype.find(@coursegroup.coursegrouptype_id).id 
    }
 end 

def test_cross_checking_with_bad_values_for_coursegrouptype_id
   @coursegroups.each { | coursegroup|
     @coursegroup = Coursegroup.find(coursegroups(coursegroup.to_sym).id)
     assert_kind_of Coursegroup, @coursegroup
     @coursegroup.coursegrouptype_id = 108
     begin 
            return true if @coursegroup.update
     rescue StandardError => x
            return false
     end
   }
 end
 

end

