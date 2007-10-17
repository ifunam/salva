require File.dirname(__FILE__) + '/../test_helper'
require 'courseduration'

class CoursedurationTest < Test::Unit::TestCase
  fixtures :coursedurations

  def setup
    @coursedurations = %w(semanal mensual )
    @mycourseduration = Courseduration.new({:name => 'Trimestral',  :days => 90 })
  end

  # Right - CRUD
  def test_creating_coursedurations_from_yaml
    @coursedurations.each { | courseduration|
      @courseduration = Courseduration.find(coursedurations(courseduration.to_sym).id)
      assert_kind_of Courseduration, @courseduration
      assert_equal coursedurations(courseduration.to_sym).id, @courseduration.id
      assert_equal coursedurations(courseduration.to_sym).name, @courseduration.name
      assert_equal coursedurations(courseduration.to_sym).days, @courseduration.days
    }
  end

  def test_updating_coursedurations_name
    @coursedurations.each { |courseduration|
      @courseduration = Courseduration.find(coursedurations(courseduration.to_sym).id)
      assert_equal coursedurations(courseduration.to_sym).name, @courseduration.name
      @courseduration.name = @courseduration.name.chars.reverse
      assert @courseduration.save
      assert_not_equal coursedurations(courseduration.to_sym).name, @courseduration.name
    }
  end

  def test_deleting_coursedurations
    @coursedurations.each { |courseduration|
      @courseduration = Courseduration.find(coursedurations(courseduration.to_sym).id)
      @courseduration.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Courseduration.find(coursedurations(courseduration.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @courseduration = Courseduration.new
    assert !@courseduration.save
  end

  def test_uniqueness
    @courseduration = Courseduration.new({:name => 'Mensual' ,  :days => 90})
    assert !@courseduration.save
  end

  # Boundary
  def test_bad_values_for_id
    # Non numeric ID
    @mycourseduration.id = 'xx'
    assert !@mycourseduration.valid?
    @mycourseduration.id = 3.14
    assert !@mycourseduration.valid?

    #@mycourseduration.id = -1
    #assert !@mybcourseduration.valid?
  end

  def test_bad_values_for_name
    @mycourseduration.name = nil
    assert !@mycourseduration.valid?
  end

  def test_bad_values_for_days
    @mycourseduration = Courseduration.new({:name => 'Semestral' })
    @mycourseduration.days = nil
    assert !@mycourseduration.save
  end
end

