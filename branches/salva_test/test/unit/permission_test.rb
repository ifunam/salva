require File.dirname(__FILE__) + '/../test_helper'
require 'action'
require 'roleingroup'
require 'controller'
require 'permission'

class PermissionTest < Test::Unit::TestCase
  fixtures  :actions, :groups, :roles, :roleingroups, :controllers, :permissions

  def setup
    @permissions = %w(administrador_salva_address_index secretaria_academica_citizen_new)
    @mypermission = Permission.new({:roleingroup_id => 1, :controller_id => 3, :action_id => 3})
  end

  # Right - CRUD
  def test_creating_permissions_from_yaml
    @permissions.each { | permission|
      @permission = Permission.find(permissions(permission.to_sym).id)
      assert_kind_of Permission, @permission
      assert_equal permissions(permission.to_sym).id, @permission.id
      assert_equal permissions(permission.to_sym).controller_id, @permission.controller_id
      assert_equal permissions(permission.to_sym).roleingroup_id, @permission.roleingroup_id
      assert_equal permissions(permission.to_sym).action_id, @permission.action_id
    }
  end

  def test_deleting_permissions
    @permissions.each { |permission|
      @permission = Permission.find(permissions(permission.to_sym).id)
      @permission.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Permission.find(permissions(permission.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @permission = Permission.new
    assert !@permission.save
  end

  def test_creating_duplicated_permission
    @permission = Permission.new({:roleingroup_id => 1, :controller_id => 2, :action_id => 1})
    assert !@permission.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mypermission.id = 1.6
    assert !@mypermission.valid?
    @mypermission.id = 'mi_id'
    assert !@mypermission.valid?
  end

  def test_bad_values_for_controller_id
    @mypermission.controller_id = nil
    assert !@mypermission.valid?

    @mypermission.controller_id= 1.6
    assert !@mypermission.valid?

    @mypermission.controller_id = 'mi_id'
    assert !@mypermission.valid?
  end

  def test_bad_values_for_roleingroup_id
    @mypermission.roleingroup_id = nil
    assert !@mypermission.valid?

    @mypermission.roleingroup_id = 3.1416
    assert !@mypermission.valid?
    @mypermission.roleingroup_id = 'mi_id'
    assert !@mypermission.valid?
  end

  def test_bad_values_for_action_id
    @mypermission.action_id = nil
    assert !@mypermission.valid?

    @mypermission.action_id = 3.1416
    assert !@mypermission.valid?
    @mypermission.action_id = 'mi_id'
    assert !@mypermission.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_action_id
    @permissions.each { | permission|
      @permission = Permission.find(permissions(permission.to_sym).id)
      assert_kind_of Permission, @permission
      assert_equal @permission.action_id, Action.find(@permission.action_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_action_id
    @permissions.each { | permission|
      @permission = Permission.find(permissions(permission.to_sym).id)
      assert_kind_of Permission, @permission
      @permission.action_id = 100000
      begin
        return true if @permission.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_roleingroup_id
    @permissions.each { | permission|
      @permission = Permission.find(permissions(permission.to_sym).id)
      assert_kind_of Permission, @permission
      assert_equal @permission.roleingroup_id, Roleingroup.find(@permission.roleingroup_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleingroup_id
    @permissions.each { | permission|
      @permission = Permission.find(permissions(permission.to_sym).id)
      assert_kind_of Permission, @permission
      @permission.roleingroup_id = 1000000
      begin
        return true if @permission.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_controller_id
    @permissions.each { | permission|
      @permission = Permission.find(permissions(permission.to_sym).id)
      assert_kind_of Permission, @permission
      assert_equal @permission.controller_id, Controller.find(@permission.controller_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_controller_id
    @permissions.each { | permission|
      @permission = Permission.find(permissions(permission.to_sym).id)
      assert_kind_of Permission, @permission
      @permission.controller_id = 100000
      begin
        return true if @permission.update
      rescue StandardError => x
        return false
      end
    }
  end
end
