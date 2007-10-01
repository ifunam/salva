require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'userrole'
require 'genericwork'
require 'user_genericwork'

class UserGenericworkTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :userroles, :genericworkgroups, :genericworktypes, :genericworkstatuses, :genericworks, :user_genericworks

  def setup
    @user_genericworks = %w(sismologia_en_mexico erosiones_en_el_golfo_de_mexico)
    @myuser_genericwork = UserGenericwork.new({:genericwork_id => 1, :user_id => 1, :userrole_id => 1})
  end

  # Right - CRUD
  def test_creating_user_genericwork_from_yaml
    @user_genericworks.each { | user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_kind_of UserGenericwork, @user_genericwork
      assert_equal user_genericworks(user_genericwork.to_sym).id, @user_genericwork.id
      assert_equal user_genericworks(user_genericwork.to_sym).genericwork_id, @user_genericwork.genericwork_id
      assert_equal user_genericworks(user_genericwork.to_sym).user_id, @user_genericwork.user_id
      assert_equal user_genericworks(user_genericwork.to_sym).userrole_id, @user_genericwork.userrole_id
    }
  end

  def test_updating_genericwork_id
    @user_genericworks.each { |user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_equal user_genericworks(user_genericwork.to_sym).genericwork_id, @user_genericwork.genericwork_id
      @user_genericwork.genericwork_id == 1? @user_genericwork.genericwork_id = @user_genericwork.genericwork_id + 1 : @user_genericwork.genericwork_id = @user_genericwork.genericwork_id - 1
      assert @user_genericwork.save
      assert_not_equal user_genericworks(user_genericwork.to_sym).genericwork_id, @user_genericwork.genericwork_id
    }
  end

  def test_updating_user_id
    @user_genericworks.each { |user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_equal user_genericworks(user_genericwork.to_sym).user_id, @user_genericwork.user_id
      @user_genericwork.user_id =  3
      assert @user_genericwork.save
      assert_not_equal user_genericworks(user_genericwork.to_sym).user_id, @user_genericwork.user_id
    }
  end

  def test_updating_userrole_id
    @user_genericworks.each { |user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_equal user_genericworks(user_genericwork.to_sym).userrole_id, @user_genericwork.userrole_id
      @user_genericwork.userrole_id =  1
      assert @user_genericwork.save
      assert_not_equal user_genericworks(user_genericwork.to_sym).userrole_id, @user_genericwork.userrole_id
    }
  end

  def test_deleting_user_genericworks
    @user_genericworks.each { |user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      @user_genericwork.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_genericwork = UserGenericwork.new
    assert !@user_genericwork.save
  end

  def test_creating_duplicated
    @user_genericwork = UserGenericwork.new({:user_id => 1, :genericwork_id => 1, :userrole_id => 3})
    assert !@user_genericwork.save
  end

  # Boundary
  def test_bad_values_for_id
    @myuser_genericwork.id = 1.6
    assert !@myuser_genericwork.valid?
    @myuser_genericwork.id = 'mi_id'
    assert !@myuser_genericwork.valid?
  end

  def test_bad_values_for_user_id
    # @myuser_genericwork.user_id = nil
    #assert !@myuser_genericwork.valid?
    @myuser_genericwork.user_id= 1.6
    assert !@myuser_genericwork.valid?
    @myuser_genericwork.user_id = 'mi_id_texto'
    assert !@myuser_genericwork.valid?
  end

  def test_bad_values_for_genericwork_id
    @myuser_genericwork.genericwork_id = nil
    assert !@myuser_genericwork.valid?
    @myuser_genericwork.genericwork_id = 1.6
    assert !@myuser_genericwork.valid?
    @myuser_genericwork.genericwork_id = 'mi_id_texto'
    assert !@myuser_genericwork.valid?
  end

  def test_bad_values_for_userrole_id
    @myuser_genericwork.userrole_id = nil
    assert !@myuser_genericwork.valid?
    @myuser_genericwork.userrole_id= 1.6
    assert !@myuser_genericwork.valid?
    @myuser_genericwork.userrole_id = 'mi_id_texto'
    assert !@myuser_genericwork.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_genericworks.each { | user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_kind_of UserGenericwork, @user_genericwork
      assert_equal @user_genericwork.user_id, User.find(@user_genericwork.user_id).id
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
    @user_genericworks.each { | user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_kind_of UserGenericwork, @user_genericwork
      @user_genericwork.user_id = 5
      begin
        return true if @user_genericwork.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for userrole
  def test_cross_checking_for_userrole_id
    @user_genericworks.each { | user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_kind_of UserGenericwork, @user_genericwork
      assert_equal @user_genericwork.userrole_id, Userrole.find(@user_genericwork.userrole_id).id
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
    @user_genericworks.each { | user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_kind_of UserGenericwork, @user_genericwork
      @user_genericwork.userrole_id = 500
      begin
        return true if @user_genericwork.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for genericwork
  def test_cross_checking_for_genericwork_id
    @user_genericworks.each { | user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_kind_of UserGenericwork, @user_genericwork
      assert_equal @user_genericwork.genericwork_id, Genericwork.find(@user_genericwork.genericwork_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_genericwork_id
    @user_genericworks.each { | user_genericwork|
      @user_genericwork = UserGenericwork.find(user_genericworks(user_genericwork.to_sym).id)
      assert_kind_of UserGenericwork, @user_genericwork
      @user_genericwork.genericwork_id = 1000
      assert @user_genericwork.valid?
      begin
        return true if @user_genericwork.save
      rescue StandardError => x
        return false
      end
    }
  end
end
