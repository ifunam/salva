require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'researchline'
require 'user_researchline'

class UserResearchlineTest < Test::Unit::TestCase
  fixtures  :userstatuses, :users, :researchareas, :researchlines, :user_researchlines

  def setup
    @user_researchlines = %w(fisica_espacial sismologia vulcanologia)
    @myuser_researchline = UserResearchline.new({:user_id => 3, :researchline_id => 1})
  end

  # Right - CRUD
  def test_creating_user_researchlines_from_yaml
    @user_researchlines.each { | user_researchline|
      @user_researchline = UserResearchline.find(user_researchlines(user_researchline.to_sym).id)
      assert_kind_of UserResearchline, @user_researchline
      assert_equal user_researchlines(user_researchline.to_sym).id, @user_researchline.id
      assert_equal user_researchlines(user_researchline.to_sym).user_id, @user_researchline.user_id
      assert_equal user_researchlines(user_researchline.to_sym).researchline_id, @user_researchline.researchline_id
    }
  end

  def test_deleting_user_researchlines
    @user_researchlines.each { |user_researchline|
      @user_researchline = UserResearchline.find(user_researchlines(user_researchline.to_sym).id)
      @user_researchline.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserResearchline.find(user_researchlines(user_researchline.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_researchline = UserResearchline.new
    assert !@user_researchline.save
  end

  def test_creating_duplicated_user_researchline
    @user_researchline = UserResearchline.new({:user_id => 3, :researchline_id => 2})
    @user_researchline.id=2
    assert !@user_researchline.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuser_researchline.id = 1.6
    assert !@myuser_researchline.valid?
    @myuser_researchline.id = 'mi_id'
    assert !@myuser_researchline.valid?
    @myuser_researchline.id = -1
    assert !@myuser_researchline.valid?
  end

  def test_bad_values_for_user_id
    @myuser_researchline.user_id = nil
    assert !@myuser_researchline.valid?

    @myuser_researchline.user_id= 1.6
    assert !@myuser_researchline.valid?

    @myuser_researchline.user_id = 'mi_id'
    assert !@myuser_researchline.valid?

    @myuser_researchline.user_id= -1
    assert !@myuser_researchline.valid?
  end

  def test_bad_values_for_researchline_id
    @myuser_researchline.researchline_id = nil
    assert !@myuser_researchline.valid?

    @myuser_researchline.researchline_id = 3.1416
    assert !@myuser_researchline.valid?
    @myuser_researchline.researchline_id = 'mi_id'
    assert !@myuser_researchline.valid?

    @myuser_researchline.researchline_id = -1
    assert !@myuser_researchline.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_researchline_id
    @user_researchlines.each { | user_researchline|
      @user_researchline = UserResearchline.find(user_researchlines(user_researchline.to_sym).id)
      assert_kind_of UserResearchline, @user_researchline
      assert_equal @user_researchline.researchline_id, Researchline.find(@user_researchline.researchline_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_researchline_id
    @user_researchlines.each { | user_researchline|
      @user_researchline = UserResearchline.find(user_researchlines(user_researchline.to_sym).id)
      assert_kind_of UserResearchline, @user_researchline
      @user_researchline.researchline_id = 100
      begin
        return true if @user_researchline.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_user_id
    @user_researchlines.each { | user_researchline|
      @user_researchline = UserResearchline.find(user_researchlines(user_researchline.to_sym).id)
      assert_kind_of UserResearchline, @user_researchline
      assert_equal @user_researchline.user_id, User.find(@user_researchline.user_id).id
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
    @user_researchlines.each { | user_researchline|
      @user_researchline = UserResearchline.find(user_researchlines(user_researchline.to_sym).id)
      assert_kind_of UserResearchline, @user_researchline
      @user_researchline.user_id = 100000
      begin
        return true if @user_researchline.save
      rescue StandardError => x
        return false
      end
    }
  end

end
