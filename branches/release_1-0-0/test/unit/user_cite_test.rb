require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'user_cite'

class UserCiteTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :user_cites

  def setup
    @user_cites = %w(admin_cites juana_cites)
    @myuser_cite = UserCite.new({:user_id => 3, :author_name => 'Flores Valdés Jorge Andrés', :total => 1 })
  end

  # Right - CRUD
  def test_creating_from_yaml
    @user_cites.each { | user_cite|
      @user_cite = UserCite.find(user_cites(user_cite.to_sym).id)
      assert_kind_of UserCite, @user_cite
      assert_equal user_cites(user_cite.to_sym).id, @user_cite.id
      assert_equal user_cites(user_cite.to_sym).user_id, @user_cite.user_id
      assert_equal user_cites(user_cite.to_sym).total, @user_cite.total
      assert_equal user_cites(user_cite.to_sym).author_name, @user_cite.author_name
    }
  end

  def test_updating_author_name
    @user_cites.each { |user_cite|
      @user_cite = UserCite.find(user_cites(user_cite.to_sym).id)
      assert_equal user_cites(user_cite.to_sym).author_name, @user_cite.author_name
      @user_cite.update_attribute('author_name', @user_cite.author_name.reverse)
      assert_not_equal user_cites(user_cite.to_sym).author_name, @user_cite.author_name
    }
  end

  def test_updating_total
    @user_cites.each { |user_cite|
      @user_cite = UserCite.find(user_cites(user_cite.to_sym).id)
      assert_equal user_cites(user_cite.to_sym).total, @user_cite.total
      @user_cite.update_attribute('total', @user_cite.total + 1)
      assert_not_equal user_cites(user_cite.to_sym).total, @user_cite.total
    }
  end

  def test_deleting
    @user_cites.each { |user_cite|
      @user_cite = UserCite.find(user_cites(user_cite.to_sym).id)
      @user_cite.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserCite.find(user_cites(user_cite.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_cite = UserCite.new
    assert !@user_cite.save
  end

  def test_uniqueness
    @user_cite = UserCite.new({:user_id => 2, :author_name => 'Ortíz y Salazar María Esther' , :total => 1})
    assert !@user_cite.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuser_cite.id = 1.6
    assert !@myuser_cite.valid?
    @myuser_cite.id = -1
    assert !@myuser_cite.valid?
    @myuser_cite.id = 'xx'
    assert !@myuser_cite.valid?
  end

  def test_bad_values_for_total
    @myuser_cite.total = nil
    assert !@myuser_cite.valid?

    @myuser_cite.total = 1.6
    assert !@myuser_cite.valid?

    @myuser_cite.total = -1
    assert !@myuser_cite.valid?

    @myuser_cite.total = 'xx'
    assert !@myuser_cite.valid?
  end

  def test_bad_values_for_user_id
    @myuser_cite.user_id = 'xx'
    assert !@myuser_cite.valid?

    @myuser_cite.user_id = -1
    assert !@myuser_cite.valid?

    @myuser_cite.user_id = 3.1416
    assert !@myuser_cite.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_user_id
    @user_cites.each { | user_cite|
      @user_cite = UserCite.find(user_cites(user_cite.to_sym).id)
      assert_kind_of UserCite, @user_cite
      assert_equal @user_cite.user_id, User.find(@user_cite.user_id).id
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
    @user_cites.each { | user_cite |
      @user_cite = UserCite.find(user_cites(user_cite.to_sym).id)
      assert_kind_of UserCite, @user_cite
      @user_cite.user_id = 10
      begin
        return true if @user_cite.save
      rescue StandardError => x
        return false
      end
    }
  end

end
