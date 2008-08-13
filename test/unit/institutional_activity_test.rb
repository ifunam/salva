require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'user'
require 'institutional_activity'

class InstitutionalActivityTest < Test::Unit::TestCase
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :userstatuses, :users, :institutional_activities

  def setup
    @institutional_activities = %w(consejo_computo consejo_directivo)
    @myinstitutional_activity = InstitutionalActivity.new({:institution_id => 3, :user_id => 3, :descr => 'Representación Educativa', :startyear => 2007 })
  end

  # Right - CRUD
  def test_creating_institutional_activities_from_yaml
    @institutional_activities.each { | institutional_activity|
      @institutional_activity = InstitutionalActivity.find(institutional_activities(institutional_activity.to_sym).id)
      assert_kind_of InstitutionalActivity, @institutional_activity
      assert_equal institutional_activities(institutional_activity.to_sym).id, @institutional_activity.id
      assert_equal institutional_activities(institutional_activity.to_sym).user_id, @institutional_activity.user_id
      assert_equal institutional_activities(institutional_activity.to_sym).institution_id, @institutional_activity.institution_id
      assert_equal institutional_activities(institutional_activity.to_sym).descr, @institutional_activity.descr
      assert_equal institutional_activities(institutional_activity.to_sym).startyear, @institutional_activity.startyear
    }
  end

  def test_updating_institutional_activities_descr
    @institutional_activities.each { |institutional_activity|
      @institutional_activity = InstitutionalActivity.find(institutional_activities(institutional_activity.to_sym).id)
      assert_equal institutional_activities(institutional_activity.to_sym).descr, @institutional_activity.descr
      @institutional_activity.descr = @institutional_activity.descr.chars.reverse
      assert @institutional_activity.save
      assert_not_equal institutional_activities(institutional_activity.to_sym).descr, @institutional_activity.descr
    }
  end

  def test_deleting_institutional_activities
    @institutional_activities.each { |institutional_activity|
      @institutional_activity = InstitutionalActivity.find(institutional_activities(institutional_activity.to_sym).id)
      @institutional_activity.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        InstitutionalActivity.find(institutional_activities(institutional_activity.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @institutional_activity = InstitutionalActivity.new
    assert !@institutional_activity.save
  end

  #def test_creating_duplicated_institutional_activity
  #  @institutional_activity = InstitutionalActivity.new({:institution_id => 5588, :user_id => 1, :descr => 'Autorización permisos sabáticos, otorgar becas, etc', :startyear => 2007})
  #  assert !@institutional_activity.save
  #end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myinstitutional_activity.id = 1.6
    assert !@myinstitutional_activity.valid?
    @myinstitutional_activity.id = 'mi_id'
    assert !@myinstitutional_activity.valid?
    @myinstitutional_activity.id = -1.0
    assert !@myinstitutional_activity.valid?
  end

  def test_bad_values_for_user_id
    @myinstitutional_activity.user_id = nil
    assert !@myinstitutional_activity.valid?

    @myinstitutional_activity.user_id= 1.6
    assert !@myinstitutional_activity.valid?

    @myinstitutional_activity.user_id= -1.0
    assert !@myinstitutional_activity.valid?

    @myinstitutional_activity.user_id = 'mi_id'
    assert !@myinstitutional_activity.valid?
  end

  def test_bad_values_for_institution_id
    @myinstitutional_activity.institution_id = nil
    assert !@myinstitutional_activity.valid?

    @myinstitutional_activity.institution_id = 3.1416
    assert !@myinstitutional_activity.valid?

    @myinstitutional_activity.institution_id = 'mi_id'
    assert !@myinstitutional_activity.valid?

    @myinstitutional_activity.institution_id = -3.0
    assert !@myinstitutional_activity.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_institution_id
    @institutional_activities.each { | institutional_activity|
      @institutional_activity = InstitutionalActivity.find(institutional_activities(institutional_activity.to_sym).id)
      assert_kind_of InstitutionalActivity, @institutional_activity
      assert_equal @institutional_activity.institution_id, Institution.find(@institutional_activity.institution_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institution_id
    @institutional_activities.each { | institutional_activity|
      @institutional_activity = InstitutionalActivity.find(institutional_activities(institutional_activity.to_sym).id)
      assert_kind_of InstitutionalActivity, @institutional_activity
      @institutional_activity.institution_id = 1000000
      begin
        return true if @institutional_activity.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_user_id
    @institutional_activities.each { | institutional_activity|
      @institutional_activity = InstitutionalActivity.find(institutional_activities(institutional_activity.to_sym).id)

      assert_kind_of InstitutionalActivity, @institutional_activity
      assert_equal @institutional_activity.user_id, User.find(@institutional_activity.user_id).id
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
    @institutional_activities.each { | institutional_activity|
      @institutional_activity = InstitutionalActivity.find(institutional_activities(institutional_activity.to_sym).id)
      assert_kind_of InstitutionalActivity, @institutional_activity
      @institutional_activity.user_id = 100000
      begin
        return true if @institutional_activity.save
      rescue StandardError => x
        return false
      end
    }
  end

end
