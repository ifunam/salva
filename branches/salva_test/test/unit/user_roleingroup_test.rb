require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'roleingroup'
require 'user_roleingroup'

class UserRoleingroupTest < Test::Unit::TestCase
  fixtures :userstatuses, :countries, :states, :cities, :users, :groups, :roles, :roleingroups, :user_roleingroups, :userstatuses

  def setup
    @user_roleingroups = %w(panchito_administrador_admin juana_estudiante_secretaria)
    @myuser_roleingroup = UserRoleingroup.new({ :user_id => 3, :roleingroup_id => 2 })
  end

  # Right - CRUD
  def test_creating_user_roleingroup_from_yaml
    @user_roleingroups.each { | user_roleingroup|
      @user_roleingroup = UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      assert_kind_of UserRoleingroup, @user_roleingroup
      assert_equal user_roleingroups(user_roleingroup.to_sym).id, @user_roleingroup.id
      assert_equal user_roleingroups(user_roleingroup.to_sym).user_id, @user_roleingroup.user_id
      assert_equal user_roleingroups(user_roleingroup.to_sym).roleingroup_id, @user_roleingroup.roleingroup_id
    }
  end

  def test_updating_roleingroup_id
    @user_roleingroups.each { |user_roleingroup|
      @user_roleingroup = UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      assert_equal user_roleingroups(user_roleingroup.to_sym).roleingroup_id, @user_roleingroup.roleingroup_id
      @user_roleingroup.roleingroup_id = 3
      assert @user_roleingroup.save
      assert_not_equal user_roleingroups(user_roleingroup.to_sym).roleingroup_id, @user_roleingroup.roleingroup_id
    }
  end

  def test_updating_user_id
    @user_roleingroups.each { |user_roleingroup|
      @user_roleingroup = UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      assert_equal user_roleingroups(user_roleingroup.to_sym).user_id, @user_roleingroup.user_id
      @user_roleingroup.user_id = 1
      assert @user_roleingroup.save
      assert_not_equal user_roleingroups(user_roleingroup.to_sym).user_id, @user_roleingroup.user_id
    }
  end

  def test_deleting_user_roleingroups
    @user_roleingroups.each { |user_roleingroup|
      @user_roleingroup = UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      @user_roleingroup.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_roleingroup = UserRoleingroup.new
    assert !@user_roleingroup.save
  end

     def test_creating_duplicated
     @user_roleingroup = UserRoleingroup.new({:user_id => 3, :roleingroup_id => 1 })
     assert !@user_roleingroup.save
   end

   # Boundary
    def test_bad_values_for_id
     @myuser_roleingroup.id = 1.6
     assert !@myuser_roleingroup.valid?
     @myuser_roleingroup.id = 'mi_id'
     assert !@myuser_roleingroup.valid?
  end

  def test_bad_values_for_user_id
    @myuser_roleingroup.user_id= 1.6
    assert !@myuser_roleingroup.valid?
    @myuser_roleingroup.user_id = 'mi_id_texto'
    assert !@myuser_roleingroup.valid?
  end

  def test_bad_values_for_roleingroup_id
    @myuser_roleingroup.roleingroup_id = nil
    assert !@myuser_roleingroup.valid?
    @myuser_roleingroup.roleingroup_id = 1.6
    assert !@myuser_roleingroup.valid?
    @myuser_roleingroup.roleingroup_id = 'mi_id_texto'
    assert !@myuser_roleingroup.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_roleingroups.each { | user_roleingroup|
      @user_roleingroup = UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      assert_kind_of UserRoleingroup, @user_roleingroup
      assert_equal @user_roleingroup.user_id, User.find(@user_roleingroup.user_id).id
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
    @user_roleingroups.each { | user_roleingroup|
      @user_roleingroup = UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      assert_kind_of UserRoleingroup, @user_roleingroup
      @user_roleingroup.user_id = 5
      begin
        return true if @user_roleingroup.save
           rescue StandardError => x
        return false
      end
    }
  end

    #cross-Checking test for roleingroup
  def test_cross_checking_for_roleingroup_id
    @user_roleingroups.each { | user_roleingroup|
      @user_roleingroup = UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      assert_kind_of UserRoleingroup, @user_roleingroup
      assert_equal @user_roleingroup.roleingroup_id, Roleingroup.find(@user_roleingroup.roleingroup_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleingroup_id
    @user_roleingroups.each { | user_roleingroup|
      @user_roleingroup = UserRoleingroup.find(user_roleingroups(user_roleingroup.to_sym).id)
      assert_kind_of UserRoleingroup, @user_roleingroup
      @user_roleingroup.roleingroup_id = 100000
      begin
        return true if @user_roleingroup.save
           rescue StandardError => x
        return false
      end
    }
  end
end
