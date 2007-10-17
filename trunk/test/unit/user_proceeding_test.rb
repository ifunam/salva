require File.dirname(__FILE__) + '/../test_helper'
require 'proceeding'
require 'roleproceeding'
require 'user'
require 'user_proceeding'

class UserProceedingTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings, :roleproceedings, :user_proceedings

  def setup
    @user_proceedings = %w(user_proceedings_01 user_proceedings_02)
    @myuser_proceeding = UserProceeding.new({:proceeding_id => 1, :roleproceeding_id => 3, :user_id => 3})
  end

  # Right - CRUD
  def test_creating_user_proceedings_from_yaml
    @user_proceedings.each { | user_proceeding|
      @user_proceeding = UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)
      assert_kind_of UserProceeding, @user_proceeding
      assert_equal user_proceedings(user_proceeding.to_sym).id, @user_proceeding.id
      assert_equal user_proceedings(user_proceeding.to_sym).roleproceeding_id, @user_proceeding.roleproceeding_id
      assert_equal user_proceedings(user_proceeding.to_sym).proceeding_id, @user_proceeding.proceeding_id
    }
  end

  def test_deleting_user_proceedings
    @user_proceedings.each { |user_proceeding|
      @user_proceeding = UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)
      @user_proceeding.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_proceeding = UserProceeding.new
    assert !@user_proceeding.save
  end

  def test_creating_duplicated_user_proceeding
    @user_proceeding = UserProceeding.new({:proceeding_id => 1, :roleproceeding_id => 2, :user_id => 3})
    assert !@user_proceeding.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuser_proceeding.id = 1.6
    assert !@myuser_proceeding.valid?
    @myuser_proceeding.id = 'mi_id'
    assert !@myuser_proceeding.valid?
  end

  def test_bad_values_for_roleproceeding_id
    @myuser_proceeding.roleproceeding_id = nil
    assert !@myuser_proceeding.valid?

    @myuser_proceeding.roleproceeding_id= 1.6
    assert !@myuser_proceeding.valid?

    @myuser_proceeding.roleproceeding_id = 'mi_id'
    assert !@myuser_proceeding.valid?
  end

  def test_bad_values_for_proceeding_id
    @myuser_proceeding.proceeding_id = nil
    assert !@myuser_proceeding.valid?

    @myuser_proceeding.proceeding_id = 3.1416
    assert !@myuser_proceeding.valid?
    @myuser_proceeding.proceeding_id = 'mi_id'
    assert !@myuser_proceeding.valid?
  end

  def test_bad_values_for_user_id
    @myuser_proceeding.user_id = nil
    assert !@myuser_proceeding.valid?

    @myuser_proceeding.user_id = 3.1416
    assert !@myuser_proceeding.valid?
    @myuser_proceeding.user_id = 'mi_id'
    assert !@myuser_proceeding.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_proceeding_id
    @user_proceedings.each { | user_proceeding|
      @user_proceeding = UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)
      assert_kind_of UserProceeding, @user_proceeding
      assert_equal @user_proceeding.proceeding_id, Proceeding.find(@user_proceeding.proceeding_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_proceeding_id
    @user_proceedings.each { | user_proceeding|
      @user_proceeding = UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)
      assert_kind_of UserProceeding, @user_proceeding
      @user_proceeding.proceeding_id = 1000000
      begin
        return true if @user_proceeding.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_roleproceeding_id
    @user_proceedings.each { | user_proceeding|
      @user_proceeding = UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)

      assert_kind_of UserProceeding, @user_proceeding
      assert_equal @user_proceeding.roleproceeding_id, Roleproceeding.find(@user_proceeding.roleproceeding_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleproceeding_id
    @user_proceedings.each { | user_proceeding|
      @user_proceeding = UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)
      assert_kind_of UserProceeding, @user_proceeding
      @user_proceeding.roleproceeding_id = 100000
      begin
        return true if @user_proceeding.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_user_id
    @user_proceedings.each { | user_proceeding|
       @user_proceeding = UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)
       assert_kind_of UserProceeding, @user_proceeding
       assert_equal @user_proceeding.user_id, User.find(@user_proceeding.user_id).id
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
    @user_proceedings.each { | user_proceeding|
      @user_proceeding = UserProceeding.find(user_proceedings(user_proceeding.to_sym).id)
      assert_kind_of UserProceeding, @user_proceeding
      @user_proceeding.user_id = 1000000
      begin
        return true if @user_proceeding.save
      rescue StandardError => x
        return false
      end
    }
  end
end
