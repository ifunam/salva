require File.dirname(__FILE__) + '/../test_helper'
require 'conference'
require 'user'
require 'roleinconference'
require 'userconference'

class UserconferenceTest < Test::Unit::TestCase
  fixtures  :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :conferences, :roleinconferences, :userconferences

  def setup
    @userconferences = %w(american_geophisycs_union_2007 relaciones_sol_tierra_2005)
    @myuserconference = Userconference.new({:conference_id => 1, :user_id => 3, :roleinconference_id => 1})
  end

  # Right - CRUD
  def test_creating_userconferences_from_yaml
    @userconferences.each { | userconference|
      @userconference = Userconference.find(userconferences(userconference.to_sym).id)
      assert_kind_of Userconference, @userconference
      assert_equal userconferences(userconference.to_sym).id, @userconference.id
      assert_equal userconferences(userconference.to_sym).roleinconference_id, @userconference.roleinconference_id
      assert_equal userconferences(userconference.to_sym).user_id, @userconference.user_id
      assert_equal userconferences(userconference.to_sym).conference_id, @userconference.conference_id

    }
  end

  def test_deleting_userconferences
    @userconferences.each { |userconference|
      @userconference = Userconference.find(userconferences(userconference.to_sym).id)
      @userconference.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Userconference.find(userconferences(userconference.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @userconference = Userconference.new
    assert !@userconference.save
  end

  def test_creating_duplicated_userconference
    @userconference = Userconference.new({:conference_id => 1, :user_id => 2, :roleinconference_id => 1})
    assert !@userconference.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuserconference.id = 1.6
    assert !@myuserconference.valid?
    @myuserconference.id = 'mi_id'
    assert !@myuserconference.valid?
  end

  def test_bad_values_for_roleinconference_id
    @myuserconference.roleinconference_id = nil
    assert !@myuserconference.valid?
    @myuserconference.roleinconference_id= 1.6
    assert !@myuserconference.valid?
    @myuserconference.roleinconference_id = 'mi_id'
    assert !@myuserconference.valid?
  end

  def test_bad_values_for_user_id
    @myuserconference.user_id = nil
    assert !@myuserconference.valid?
    @myuserconference.user_id= 1.6
    assert !@myuserconference.valid?
    @myuserconference.user_id = 'mi_id'
    assert !@myuserconference.valid?
  end

  def test_bad_values_for_conference_id
    @myuserconference.conference_id = nil
    assert !@myuserconference.valid?
    @myuserconference.conference_id= 1.6
    assert !@myuserconference.valid?
    @myuserconference.conference_id = 'mi_id'
    assert !@myuserconference.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_Roleinconference_id
    @userconferences.each { | userconference|
      @userconference = Userconference.find(userconferences(userconference.to_sym).id)
      assert_kind_of Userconference, @userconference
      assert_equal @userconference.roleinconference_id, Roleinconference.find(@userconference.roleinconference_id).id
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
    @userconferences.each { | userconference|
      @userconference = Userconference.find(userconferences(userconference.to_sym).id)
      assert_kind_of Userconference, @userconference
      @userconference.roleinconference_id = 50
      begin
        return true if @userconference.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for user
  def test_cross_checking_for_user_id
    @userconferences.each { | userconference|
      @userconference = Userconference.find(userconferences(userconference.to_sym).id)
      assert_kind_of Userconference, @userconference
      assert_equal @userconference.user_id, User.find(@userconference.user_id).id
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
    @userconferences.each { | userconference|
      @userconference = Userconference.find(userconferences(userconference.to_sym).id)
      assert_kind_of Userconference, @userconference
      @userconference.user_id = 20
      begin
        return true if @userconference.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for conference
  def test_cross_checking_for_conference_id
    @userconferences.each { | userconference|
      @userconference = Userconference.find(userconferences(userconference.to_sym).id)
      assert_kind_of Userconference, @userconference
      assert_equal @userconference.conference_id, Conference.find(@userconference.conference_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_conference_id
    @userconferences.each { | userconference|
      @userconference = Userconference.find(userconferences(userconference.to_sym).id)
      assert_kind_of Userconference, @userconference
      @userconference.conference_id = 20
      begin
        return true if @userconference.update
      rescue StandardError => x
        return false
      end
    }
  end

end
