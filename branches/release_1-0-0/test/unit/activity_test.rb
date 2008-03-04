require File.dirname(__FILE__) + '/../test_helper'
require 'activitytype'
require 'activity'

class ActivityTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :activitygroups, :activitytypes, :activities

  def setup
    @activities = %w(opiniones conferencias programas_de_estudios)
    @myactivity = Activity.new({ :user_id =>1, :name => 'Opiniones', :activitytype_id => 1, :year => 1984})
  end

  # Right - CRUD
  def test_creating_gactivities_from_yaml
    @activities.each { | activity|
      @activity = Activity.find(activities(activity.to_sym).id)
      assert_kind_of Activity, @activity
      assert_equal activities(activity.to_sym).id, @activity.id
      assert_equal activities(activity.to_sym).name, @activity.name
      assert_equal activities(activity.to_sym).activitytype_id, @activity.activitytype_id
    }
  end

  def test_updating_gactivities_name
    @activities.each { |activity|
      @activity = Activity.find(activities(activity.to_sym).id)
      assert_equal activities(activity.to_sym).name, @activity.name
      @activity.name = @activity.name.chars.reverse
      assert @activity.save
      assert_not_equal activities(activity.to_sym).name, @activity.name
    }
  end

  def test_deleting_activities
    @activities.each { |activity|
      @activity = Activity.find(activities(activity.to_sym).id)
      @activity.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Activity.find(activities(activity.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @myactivity = Activity.new
    assert !@myactivity.save
  end

  def test_creating_with_empty_attributes
    @myactivity = Activity.new({ :name => 'Conferencias', :activitytype_id => 2, :year => 1984 })
    assert !@myactivity.save
    @myactivity = Activity.new({  :user_id =>1, :name => 'Conferencias',  :year => 1984 })
    assert !@myactivity.save
    @myactivity = Activity.new({  :user_id =>1, :name => 'Conferencias', :activitytype_id => 2 })
    assert !@myactivity.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myactivity.id = 1.6
    assert !@myactivity.valid?
    @myactivity.id = 'xx'
    assert !@myactivity.valid?
    @myactivity.id = -1
    assert !@myactivity.valid?
  end

  def test_bad_values_for_name
    @myactivity.name = nil
    assert !@myactivity.valid?
  end

  def test_bad_values_for_activitytype_id
    # Checking constraints for name
    # Nil name
    @myactivity.activitytype_id = 3.1416
    assert !@myactivity.valid?
    @myactivity.activitytype_id = 'xx'
    assert !@myactivity.valid?
   @myactivity.activitytype_id = -3.0
    assert !@myactivity.valid?
  end

  def test_bad_values_for_user_id
    # Checking constraints for name
    # Nil name
    @myactivity.user_id = 3.1416
    assert !@myactivity.valid?
    @myactivity.user_id = 'xx'
    assert !@myactivity.valid?
    @myactivity.user_id = -1
    assert !@myactivity.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_user_id
    @activities.each { | activity|
      @activity = Activity.find(activities(activity.to_sym).id)
      assert_kind_of Activity, @activity
      assert_equal @activity.user_id, User.find(@activity.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @activities.each { | activity|
      @activity = Activity.find(activities(activity.to_sym).id)
      assert_kind_of Activity, @activity
      @activity.user_id = 10
      begin
        return true if @activity.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_activitytype_id
    @activities.each { | activity|
      @activity = Activity.find(activities(activity.to_sym).id)
      assert_kind_of Activity, @activity
      assert_equal @activity.activitytype_id, User.find(@activity.activitytype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_activitytype_id
    @activities.each { | activity|
      @activity = Activity.find(activities(activity.to_sym).id)
      assert_kind_of Activity, @activity
      @activity.activitytype_id = 10
      begin
        return true if @activity.save
      rescue StandardError => x
        return false
      end
    }
  end

end
