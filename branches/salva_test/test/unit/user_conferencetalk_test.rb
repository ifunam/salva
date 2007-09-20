require File.dirname(__FILE__) + '/../test_helper'
require 'conference'
require 'user'
require 'roleinconference'
require 'userconference'
require 'user_conferencetalk'

class UserConferencetalkTest < Test::Unit::TestCase
  fixtures  :roleinconferences, :roleinconferencetalks, :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :talkacceptances, :modalities, :talktypes, :conferences, :conferencetalks, :user_conferencetalks

  def setup
    @userconferencetalks = %w(american_geophisycs_union union_geofisica_mexicana)
    @myuserconferencetalk = UserConferencetalk.new({:user_id => 3, :roleinconferencetalk_id => 2})
  end

  # Right - CRUD
  def test_creating_userconferencetalks_from_yaml
    @userconferencetalks.each { | user_conferencetalk|
      @userconferencetalk = UserConferencetalk.find(user_conferencetalks(user_conferencetalk.to_sym).id)
      assert_kind_of UserConferencetalk, @userconferencetalk
      assert_equal user_conferencetalks(user_conferencetalk.to_sym).id, @userconferencetalk.id
      assert_equal user_conferencetalks(user_conferencetalk.to_sym).roleinconferencetalk_id, @userconferencetalk.roleinconferencetalk_id
      assert_equal user_conferencetalks(user_conferencetalk.to_sym).user_id, @userconferencetalk.user_id
    }
  end

  def test_deleting_userconferencetalks
    @userconferencetalks.each { |user_conferencetalk|
      @userconferencetalk = UserConferencetalk.find(user_conferencetalks(user_conferencetalk.to_sym).id)
      @userconferencetalk.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserConferencetalk.find(user_conferencetalks(user_conferencetalk.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @userconferencetalk = UserConferencetalk.new
    assert !@userconferencetalk.save
  end

  def test_creating_duplicated_userconference
    @userconferencetalk = UserConferencetalk.new({:user_id => 2, :roleinconferencetalk_id => 1})
    assert !@userconferencetalk.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuserconferencetalk.id = 1.6
    assert !@myuserconferencetalk.valid?
    @myuserconferencetalk.id = 'mi_id'
    assert !@myuserconferencetalk.valid?
  end

  def test_bad_values_for_roleinconference_id
    @myuserconferencetalk.roleinconferencetalk_id = nil
    assert !@myuserconferencetalk.valid?
    @myuserconferencetalk.roleinconferencetalk_id= 1.6
    assert !@myuserconferencetalk.valid?
    @myuserconferencetalk.roleinconferencetalk_id = 'mi_id'
    assert !@myuserconferencetalk.valid?
  end

  def test_bad_values_for_user_id
    @myuserconferencetalk.user_id = nil
    assert !@myuserconferencetalk.valid?
    @myuserconferencetalk.user_id= 1.6
    assert !@myuserconferencetalk.valid?
    @myuserconferencetalk.user_id = 'mi_id'
    assert !@myuserconferencetalk.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_Roleinconference_id
    @userconferencetalks.each { | user_conferencetalk|
      @userconferencetalk = UserConferencetalk.find(user_conferencetalks(user_conferencetalk.to_sym).id)
      assert_kind_of UserConferencetalk, @userconferencetalk
      assert_equal @userconferencetalk.roleinconferencetalk_id, Roleinconferencetalk.find(@userconferencetalk.roleinconferencetalk_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleinconference_id
    @userconferencetalks.each { | user_conferencetalk|
      @userconferencetalk = UserConferencetalk.find(user_conferencetalks(user_conferencetalk.to_sym).id)
      assert_kind_of UserConferencetalk, @userconferencetalk
      @userconferencetalk.roleinconferencetalk_id = 50
      begin
        return true if @userconferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for user
  def test_cross_checking_for_user_id
    @userconferencetalks.each { | user_conferencetalk|
      @userconferencetalk = UserConferencetalk.find(user_conferencetalks(user_conferencetalk.to_sym).id)
      assert_kind_of UserConferencetalk, @userconferencetalk
      assert_equal @userconferencetalk.user_id, User.find(@userconferencetalk.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @userconferencetalks.each { | user_conferencetalk|
      @userconferencetalk = UserConferencetalk.find(user_conferencetalks(user_conferencetalk.to_sym).id)
      assert_kind_of UserConferencetalk, @userconferencetalk
      @userconferencetalk.user_id = 20
      begin
        return true if @userconferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for conference
  def test_cross_checking_for_conference_id
    @userconferencetalks.each { | user_conferencetalk|
      @userconferencetalk = UserConferencetalk.find(user_conferencetalks(user_conferencetalk.to_sym).id)
      assert_kind_of UserConferencetalk, @userconferencetalk
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
