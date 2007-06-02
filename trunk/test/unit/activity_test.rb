require File.dirname(__FILE__) + '/../test_helper'
require 'activitytype'
require 'activity'

class ActivityTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :activitygroups, :activitytypes, :activities

  def setup
    @activities = %w(opiniones conferencias programas_de_estudios)
    @myactivity = Activity.new({:name => 'Opiniones', :activitytype_id => 1})
  end

  # Right - CRUD
  def test_creating_activities_from_yaml
    @activities.each { | activity|
      @activity = Activity.find(activities(activity.to_sym).activitytype_id)
      assert_kind_of Activity, @activity
      assert_equal activities(activity.to_sym).activitytype_id, @activity.activitytype_id
      assert_equal activities(activity.to_sym).name, @activity.name
      assert_equal activities(activity.to_sym).activitytype_id, @activity.activitytype_id
    }
  end
  
  def test_updating_activities_name
    @activities.each { |activity|
      @activity = Activity.find(activities(activity.to_sym).activitytype_id)
      assert_equal activities(activity.to_sym).name, @activity.name
      @activity.name = @activity.name.chars.reverse 
      assert @activity.update
      assert_not_equal activities(activity.to_sym).name, @activity.name
    }
  end  

  def test_deleting_activities
    @activities.each { |activity|
      @activity = Activity.find(activities(activity.to_sym).activitytype_id)
      @activity.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Activity.find(activities(activity.to_sym).activitytype_id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @activity = Activity.new
     assert !@activity.save
   end

   def test_creating_duplicated_activity
     @activity = Activity.new({:name => 'Conferencias', :activitytype_id => 2})
     @activity.activitytype.id = 2
     assert !@activity.save
   end

     # Boundary 
   def test_bad_values_for_id
     # Float number for ID 
     @myactivity.id = 1.6
     assert !@myactivity.valid?
   end

   def test_bad_values_for_name
     @myactivity.name = nil
     assert !@myactivity.valid?

     @myactivity.name = 'AB' 
     assert !@myactivity.valid?

     @myactivity.name = 'AB' * 800
     assert !@myactivity.valid?
   end

   def test_bad_values_for_activity_id
     # Checking constraints for name
     # Nil name
     @myactivity.activitytype_id = nil
     assert !@myactivity.valid?

     @myactivity.activitytype_id = 3.1416
    assert !@myactivity.valid?
   end

   #Cross-Checking test
 
 def test_cross_checking_with_bad_values_for_activity_id
   @activities.each { | activity|
      @activity = Activity.find(activities(activity.to_sym).activitytype_id)
      assert_kind_of Activity, @activity
      @activity.activitytype_id = 10
      begin 
            return true if @activity.update
      rescue StandardError => x
            return false
      end
   }
 end 

 def catch_exception_when_update_invalid_key(record)
   begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
end

end
