require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'roleinseminary'
require 'seminary'
require 'user_seminary'

class UserSeminaryTest < Test::Unit::TestCase
  fixtures :userstatuses, :countries, :states, :cities, :users, :institutiontypes, :institutiontitles, :institutions, :roleinseminaries, :seminaries, :user_seminaries

  def setup
    @user_seminaries = %w(juana_analisis_de_onda_P panchito_analisis_de_onda_P)
    @myuser_seminary = UserSeminary.new({ :user_id => 1, :seminary_id => 2, :roleinseminary_id => 2 })
  end

  # Right - CRUD
  def test_creating_user_seminary_from_yaml
    @user_seminaries.each { | user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_kind_of UserSeminary, @user_seminary
      assert_equal user_seminaries(user_seminary.to_sym).id, @user_seminary.id
      assert_equal user_seminaries(user_seminary.to_sym).user_id, @user_seminary.user_id
      assert_equal user_seminaries(user_seminary.to_sym).seminary_id, @user_seminary.seminary_id
      assert_equal user_seminaries(user_seminary.to_sym).roleinseminary_id, @user_seminary.roleinseminary_id
    }
  end

  def test_updating_seminary_id
    @user_seminaries.each { |user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_equal user_seminaries(user_seminary.to_sym).seminary_id, @user_seminary.seminary_id
      @user_seminary.seminary_id = 4
      assert @user_seminary.update
      assert_not_equal user_seminaries(user_seminary.to_sym).seminary_id, @user_seminary.seminary_id
    }
  end

  def test_updating_user_id
    @user_seminaries.each { |user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_equal user_seminaries(user_seminary.to_sym).user_id, @user_seminary.user_id
      @user_seminary.user_id = 1
      assert @user_seminary.update
      assert_not_equal user_seminaries(user_seminary.to_sym).user_id, @user_seminary.user_id
    }
  end

  def test_updating_roleinseminary_id
    @user_seminaries.each { |user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_equal user_seminaries(user_seminary.to_sym).roleinseminary_id, @user_seminary.roleinseminary_id
      @user_seminary.roleinseminary_id = 3
      assert @user_seminary.update
      assert_not_equal user_seminaries(user_seminary.to_sym).roleinseminary_id, @user_seminary.roleinseminary_id
    }
  end

  def test_deleting_user_seminaries
    @user_seminaries.each { |user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      @user_seminary.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_seminary = UserSeminary.new
    assert !@user_seminary.save
  end

  def test_creating_duplicated
    @user_seminary = UserSeminary.new({:user_id => 2, :seminary_id => 2, :roleinseminary_id => 1 })
    assert !@user_seminary.save
  end

  # Boundary
  def test_bad_values_for_id
    @myuser_seminary.id = 1.6
    assert !@myuser_seminary.valid?
    @myuser_seminary.id = 'mi_id'
    assert !@myuser_seminary.valid?
  end

  def test_bad_values_for_user_id
    @myuser_seminary.user_id= 1.6
    assert !@myuser_seminary.valid?
    @myuser_seminary.user_id = 'mi_id_texto'
    assert !@myuser_seminary.valid?
  end

  def test_bad_values_for_seminary_id
    @myuser_seminary.seminary_id = nil
    assert !@myuser_seminary.valid?
    @myuser_seminary.seminary_id = 1.6
    assert !@myuser_seminary.valid?
    @myuser_seminary.seminary_id = 'mi_id_texto'
    assert !@myuser_seminary.valid?
  end

  def test_bad_values_for_roleinseminary_id
    @myuser_seminary.roleinseminary_id = nil
    assert !@myuser_seminary.valid?
    @myuser_seminary.roleinseminary_id = 1.6
    assert !@myuser_seminary.valid?
    @myuser_seminary.roleinseminary_id = 'mi_id_texto'
    assert !@myuser_seminary.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_seminaries.each { | user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_kind_of UserSeminary, @user_seminary
      assert_equal @user_seminary.user_id, User.find(@user_seminary.user_id).id
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
    @user_seminaries.each { | user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_kind_of UserSeminary, @user_seminary
      @user_seminary.user_id = 5
      begin
        return true if @user_seminary.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for seminary
  def test_cross_checking_for_seminary_id
    @user_seminaries.each { | user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_kind_of UserSeminary, @user_seminary
      assert_equal @user_seminary.seminary_id, Seminary.find(@user_seminary.seminary_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_seminary_id
    @user_seminaries.each { | user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_kind_of UserSeminary, @user_seminary
      @user_seminary.seminary_id = 100000
      begin
        return true if @user_seminary.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for roleinseminary
  def test_cross_checking_for_roleinseminary_id
    @user_seminaries.each { | user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_kind_of UserSeminary, @user_seminary
      assert_equal @user_seminary.roleinseminary_id, Roleinseminary.find(@user_seminary.roleinseminary_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleinseminary_id
    @user_seminaries.each { | user_seminary|
      @user_seminary = UserSeminary.find(user_seminaries(user_seminary.to_sym).id)
      assert_kind_of UserSeminary, @user_seminary
      @user_seminary.roleinseminary_id = 100000
      begin
        return true if @user_seminary.update
      rescue StandardError => x
        return false
      end
    }
  end
end
