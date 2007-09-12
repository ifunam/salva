require File.dirname(__FILE__) + '/../test_helper'
require 'group'
require 'role'
require 'roleingroup'

class RoleingroupTest < Test::Unit::TestCase
  fixtures :groups, :roles, :roleingroups

  def setup
    @roleingroups = %w(administrador_admin estudiante_secretaria)
    @myroleingroup = Roleingroup.new({ :group_id => 1, :role_id => 2})
  end

  # Right - CRUD
  def test_creating_roleingroup_from_yaml
    @roleingroups.each { | roleingroup|
      @roleingroup = Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      assert_kind_of Roleingroup, @roleingroup
      assert_equal roleingroups(roleingroup.to_sym).id, @roleingroup.id
      assert_equal roleingroups(roleingroup.to_sym).role_id, @roleingroup.role_id
      assert_equal roleingroups(roleingroup.to_sym).group_id, @roleingroup.group_id
    }
  end

  def test_updating_role_id
    @roleingroups.each { |roleingroup|
      @roleingroup = Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      assert_equal roleingroups(roleingroup.to_sym).role_id, @roleingroup.role_id
      @roleingroup.role_id = 4
      assert @roleingroup.update
      assert_not_equal roleingroups(roleingroup.to_sym).role_id, @roleingroup.role_id
    }
  end

   def test_updating_group_id
    @roleingroups.each { |roleingroup|
      @roleingroup = Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      assert_equal roleingroups(roleingroup.to_sym).group_id, @roleingroup.group_id
      @roleingroup.group_id = 2
      assert @roleingroup.update
      assert_not_equal roleingroups(roleingroup.to_sym).group_id, @roleingroup.group_id
    }
  end

  def test_deleting_roleingroups
    @roleingroups.each { |roleingroup|
      @roleingroup = Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      @roleingroup.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @roleingroup = Roleingroup.new
    assert !@roleingroup.save
  end

     def test_creating_duplicated
     @roleingroup = Roleingroup.new({:role_id => 1, :group_id => 1})
     assert !@roleingroup.save
   end

   # Boundary
    def test_bad_values_for_id
     @myroleingroup.id = 1.6
     assert !@myroleingroup.valid?
     @myroleingroup.id = 'mi_id'
     assert !@myroleingroup.valid?
  end

  def test_bad_values_for_role_id
    @myroleingroup.role_id= 1.6
    assert !@myroleingroup.valid?
    @myroleingroup.role_id = 'mi_id_texto'
    assert !@myroleingroup.valid?
  end

  def test_bad_values_for_group_id
    @myroleingroup.group_id = nil
    assert !@myroleingroup.valid?
    @myroleingroup.group_id = 1.6
    assert !@myroleingroup.valid?
    @myroleingroup.group_id = 'mi_id_texto'
    assert !@myroleingroup.valid?
  end

  #cross-Checking test for role
  def test_cross_checking_for_role_id
    @roleingroups.each { | roleingroup|
      @roleingroup = Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      assert_kind_of Roleingroup, @roleingroup
      assert_equal @roleingroup.role_id, Role.find(@roleingroup.role_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_role_id
    @roleingroups.each { | roleingroup|
      @roleingroup = Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      assert_kind_of Roleingroup, @roleingroup
      @roleingroup.role_id = 5000
      begin
        return true if @roleingroup.update
           rescue StandardError => x
        return false
      end
    }
  end

    #cross-Checking test for group
  def test_cross_checking_for_group_id
    @roleingroups.each { | roleingroup|
      @roleingroup = Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      assert_kind_of Roleingroup, @roleingroup
      assert_equal @roleingroup.group_id, Group.find(@roleingroup.group_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_group_id
    @roleingroups.each { | roleingroup|
      @roleingroup = Roleingroup.find(roleingroups(roleingroup.to_sym).id)
      assert_kind_of Roleingroup, @roleingroup
      @roleingroup.group_id = 100000
      begin
        return true if @roleingroup.update
           rescue StandardError => x
        return false
      end
    }
  end
end
