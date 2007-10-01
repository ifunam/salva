require File.dirname(__FILE__) + '/../test_helper'
require 'activitygroup'
require 'activitytype'

class ActivitytypeTest < Test::Unit::TestCase
  fixtures :activitygroups, :activitytypes

  def setup
    @activitytypes = %w(reportajes programas_de_radio entrevistas)
    @myactivitytype = Activitytype.new({:name => 'Servicios de apoyo', :activitygroup_id => 3})
  end

  # Right - CRUD
  def test_creating_from_yaml
    @activitytypes.each { | activitytype|
      @activitytype = Activitytype.find(activitytypes(activitytype.to_sym).id)
      assert_kind_of Activitytype, @activitytype
      assert_equal activitytypes(activitytype.to_sym).id, @activitytype.id
      assert_equal activitytypes(activitytype.to_sym).name, @activitytype.name
      assert_equal activitytypes(activitytype.to_sym).activitygroup_id, @activitytype.activitygroup_id
    }
  end

  def test_updating_name
    @activitytypes.each { |activitytype|
      @activitytype = Activitytype.find(activitytypes(activitytype.to_sym).id)
      assert_equal activitytypes(activitytype.to_sym).name, @activitytype.name
      @activitytype.name = @activitytype.name.chars.reverse
      assert @activitytype.save
      assert_not_equal activitytypes(activitytype.to_sym).name, @activitytype.name
    }
  end

  def test_deleting
    @activitytypes.each { |activitytype|
      @activitytype = Activitytype.find(activitytypes(activitytype.to_sym).id)
      @activitytype.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Activitytype.find(activitytypes(activitytype.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @activitytype = Activitytype.new
    assert !@activitytype.save
  end

  def test_uniqueness
    @activitytype = Activitytype.new({:name => 'Reportajes', :activitygroup_id => 1})
    assert !@activitytype.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myactivitytype.id = 1.6
    assert !@myactivitytype.valid?
    #@myactivitytype.id = -1
    #assert !@myactivitytype.valid?
    @myactivitytype.id = 'xx'
    assert !@myactivitytype.valid?

  end

  def test_bad_values_for_name
    @myactivitytype.name = nil
    assert !@myactivitytype.valid?
  end

  def test_bad_values_for_activitygroup_id
    @myactivitytype.activitygroup_id = 'xx'
    assert !@myactivitytype.valid?

    #@myactivitytype.activitygroup_id = -1
    #assert !@myactivitytype.valid?

    @myactivitytype.activitygroup_id = 3.1416
    assert !@myactivitytype.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_activity_group_id
    @activitytypes.each { | activitytype|
      @activitytype = Activitytype.find(activitytypes(activitytype.to_sym).id)
      assert_kind_of Activitytype, @activitytype
      assert_equal @activitytype.activitygroup_id, Activitygroup.find(@activitytype.activitygroup_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_activitygroup_id
    @activitytypes.each { | activitytype |
      @activitytype = Activitytype.find(activitytypes(activitytype.to_sym).id)
      assert_kind_of Activitytype, @activitytype
      @activitytype.activitygroup_id = 10
      begin
        return true if @activitytype.save
      rescue StandardError => x
        return false
      end
    }
  end

end

