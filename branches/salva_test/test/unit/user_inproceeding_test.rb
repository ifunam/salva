require File.dirname(__FILE__) + '/../test_helper'
require 'inproceeding'
require 'user_inproceeding'

class UserInproceedingTest < Test::Unit::TestCase
  fixtures  :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings, :inproceedings, :user_inproceedings

  def setup
    @user_inproceedings = %w(coautor autor)
    @myuser_inproceeding = UserInproceeding.new({ :inproceeding_id => 2, :ismainauthor => false})
  end

  # Right - CRUD
  def test_creating_user_inproceedings_from_yaml
    @user_inproceedings.each { | user_inproceeding|
      @user_inproceeding = UserInproceeding.find(user_inproceedings(user_inproceeding.to_sym).id)
      assert_kind_of UserInproceeding, @user_inproceeding
      assert_equal user_inproceedings(user_inproceeding.to_sym).id, @user_inproceeding.id
      assert_equal user_inproceedings(user_inproceeding.to_sym).inproceeding_id, @user_inproceeding.inproceeding_id
      assert_equal user_inproceedings(user_inproceeding.to_sym).ismainauthor, @user_inproceeding.ismainauthor
    }
  end

  def test_deleting_user_inproceedings
    @user_inproceedings.each { |user_inproceeding|
      @user_inproceeding = UserInproceeding.find(user_inproceedings(user_inproceeding.to_sym).id)
      @user_inproceeding.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserInproceeding.find(user_inproceedings(user_inproceeding.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_inproceeding = UserInproceeding.new
    assert !@user_inproceeding.save
  end

  def test_creating_duplicated_user_inproceeding
    @user_inproceeding = UserInproceeding.new({:inproceeding_id => 1, :ismainauthor => false})
    assert !@user_inproceeding.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuser_inproceeding.id = 1.6
    assert !@myuser_inproceeding.valid?
    @myuser_inproceeding.id = 'mi_id'
    assert !@myuser_inproceeding.valid?
    @myuser_inproceeding.id = -1.0
    assert !@myuser_inproceeding.valid?
  end

  def test_bad_values_for_inproceeding_id
    @myuser_inproceeding.inproceeding_id = nil
    assert !@myuser_inproceeding.valid?

    @myuser_inproceeding.inproceeding_id= 1.6
    assert !@myuser_inproceeding.valid?

    @myuser_inproceeding.inproceeding_id = 'mi_id'
    assert !@myuser_inproceeding.valid?

    @myuser_inproceeding.inproceeding_id= -1.0
    assert !@myuser_inproceeding.valid?
  end

  def test_bad_values_for_ismainauthor
    @myuser_inproceeding.ismainauthor = nil
    assert !@myuser_inproceeding.valid?
    @myuser_inproceeding.ismainauthor = 1.6
    assert !@myuser_inproceeding.valid?
    @myuser_inproceeding.ismainauthor = 'my_ismainauthor'
    assert !@myuser_inproceeding.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_inproceeding_id
    @user_inproceedings.each { | user_inproceeding|
      @user_inproceeding = UserInproceeding.find(user_inproceedings(user_inproceeding.to_sym).id)

      assert_kind_of UserInproceeding, @user_inproceeding
      assert_equal @user_inproceeding.inproceeding_id, Inproceeding.find(@user_inproceeding.inproceeding_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_inproceeding_id
    @user_inproceedings.each { | user_inproceeding|
      @user_inproceeding = UserInproceeding.find(user_inproceedings(user_inproceeding.to_sym).id)
      assert_kind_of UserInproceeding, @user_inproceeding
      @user_inproceeding.inproceeding_id = 100000
      begin
        return true if @user_inproceeding.save
      rescue StandardError => x
        return false
      end
    }
  end

end
