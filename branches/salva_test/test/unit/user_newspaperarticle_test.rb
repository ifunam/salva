require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'newspaperarticle'
require 'user_newspaperarticle'

class UserNewspaperarticleTest < Test::Unit::TestCase
 fixtures  :userstatuses, :users, :countries, :newspapers, :newspaperarticles, :user_newspaperarticles
  def setup
    @user_newspaperarticles = %w(user_newspaperarticles_01 user_newspaperarticles_02)
    @myuser_newspaperarticle = UserNewspaperarticle.new({:user_id => 1, :newspaperarticle_id => 3, :ismainauthor => true})
  end

  # Right - CRUD
  def test_creating_user_newspaperarticles_from_yaml
    @user_newspaperarticles.each { | user_newspaperarticle|
      @user_newspaperarticle = UserNewspaperarticle.find(user_newspaperarticles(user_newspaperarticle.to_sym).id)
      assert_kind_of UserNewspaperarticle, @user_newspaperarticle
      assert_equal user_newspaperarticles(user_newspaperarticle.to_sym).id, @user_newspaperarticle.id
      assert_equal user_newspaperarticles(user_newspaperarticle.to_sym).newspaperarticle_id, @user_newspaperarticle.newspaperarticle_id
      assert_equal user_newspaperarticles(user_newspaperarticle.to_sym).user_id, @user_newspaperarticle.user_id
    }
  end

  def test_deleting_user_newspaperarticles
    @user_newspaperarticles.each { |user_newspaperarticle|
      @user_newspaperarticle = UserNewspaperarticle.find(user_newspaperarticles(user_newspaperarticle.to_sym).id)
      @user_newspaperarticle.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserNewspaperarticle.find(user_newspaperarticles(user_newspaperarticle.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_newspaperarticle = UserNewspaperarticle.new
    assert !@user_newspaperarticle.save
  end

  def test_creating_duplicated_user_newspaperarticle
    @user_newspaperarticle = UserNewspaperarticle.new({:user_id => 2, :newspaperarticle_id => 1, :ismainauthor => true})
    assert !@user_newspaperarticle.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuser_newspaperarticle.id = 1.6
    assert !@myuser_newspaperarticle.valid?
    @myuser_newspaperarticle.id = 'mi_id'
    assert !@myuser_newspaperarticle.valid?
  end

  def test_bad_values_for_newspaperarticle_id
    @myuser_newspaperarticle.newspaperarticle_id = nil
    assert !@myuser_newspaperarticle.valid?

    @myuser_newspaperarticle.newspaperarticle_id= 1.6
    assert !@myuser_newspaperarticle.valid?

    @myuser_newspaperarticle.newspaperarticle_id = 'mi_id'
    assert !@myuser_newspaperarticle.valid?
  end

  def test_bad_values_for_user_id
    @myuser_newspaperarticle.user_id = nil
    assert !@myuser_newspaperarticle.valid?

    @myuser_newspaperarticle.user_id = 3.1416
    assert !@myuser_newspaperarticle.valid?
    @myuser_newspaperarticle.user_id = 'mi_id'
    assert !@myuser_newspaperarticle.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_user_id
    @user_newspaperarticles.each { | user_newspaperarticle|
      @user_newspaperarticle = UserNewspaperarticle.find(user_newspaperarticles(user_newspaperarticle.to_sym).id)
      assert_kind_of UserNewspaperarticle, @user_newspaperarticle
      assert_equal @user_newspaperarticle.user_id, User.find(@user_newspaperarticle.user_id).id
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
    @user_newspaperarticles.each { | user_newspaperarticle|
      @user_newspaperarticle = UserNewspaperarticle.find(user_newspaperarticles(user_newspaperarticle.to_sym).id)
      assert_kind_of UserNewspaperarticle, @user_newspaperarticle
      @user_newspaperarticle.user_id = 1000000
      begin
        return true if @user_newspaperarticle.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_newspaperarticle_id
    @user_newspaperarticles.each { | user_newspaperarticle|
      @user_newspaperarticle = UserNewspaperarticle.find(user_newspaperarticles(user_newspaperarticle.to_sym).id)

      assert_kind_of UserNewspaperarticle, @user_newspaperarticle
      assert_equal @user_newspaperarticle.newspaperarticle_id, Newspaperarticle.find(@user_newspaperarticle.newspaperarticle_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_newspaperarticle_id
    @user_newspaperarticles.each { | user_newspaperarticle|
      @user_newspaperarticle = UserNewspaperarticle.find(user_newspaperarticles(user_newspaperarticle.to_sym).id)
      assert_kind_of UserNewspaperarticle, @user_newspaperarticle
      @user_newspaperarticle.newspaperarticle_id = 100000
      begin
        return true if @user_newspaperarticle.save
      rescue StandardError => x
        return false
      end
    }
  end

end
