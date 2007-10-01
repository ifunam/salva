require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'roleinproject'
require 'project'

class UserProjectTest < Test::Unit::TestCase
  fixtures  :userstatuses, :users, :projecttypes, :projectstatuses, :roleinprojects, :projects, :user_projects

  def setup
    @user_projects = %w(proyecto_salva proyecto_issste)
    @myuser_project = UserProject.new({ :project_id => 1, :user_id => 2 , :roleinproject_id => 3})
  end

  # Right - CRUD
  def test_creating_user_project_from_yaml
    @user_projects.each { | user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_kind_of UserProject, @user_project
      assert_equal user_projects(user_project.to_sym).id, @user_project.id
      assert_equal user_projects(user_project.to_sym).user_id, @user_project.user_id
      assert_equal user_projects(user_project.to_sym).roleinproject_id, @user_project.roleinproject_id
      assert_equal user_projects(user_project.to_sym).project_id, @user_project.project_id
    }
  end

  def test_updating_user_project_id
    @user_projects.each { |user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_equal user_projects(user_project.to_sym).project_id, @user_project.project_id
      @user_project.project_id = 3
      assert @user_project.save
      assert_not_equal user_projects(user_project.to_sym).project_id, @user_project.project_id
    }
  end

  def test_updating_user_id
    @user_projects.each { |user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_equal user_projects(user_project.to_sym).user_id, @user_project.user_id
      @user_project.user_id = 3
      assert @user_project.save
      assert_not_equal user_projects(user_project.to_sym).user_id, @user_project.user_id
    }
  end

  def test_updating_roleinproject_id
    @user_projects.each { |user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_equal user_projects(user_project.to_sym).roleinproject_id, @user_project.roleinproject_id
      @user_project.roleinproject_id = 2
      assert @user_project.save
      assert_not_equal user_projects(user_project.to_sym).roleinproject_id, @user_project.roleinproject_id
    }
  end

  def test_deleting_user_project
    @user_projects.each { |user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      @user_project.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserProject.find(user_projects(user_project.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_project = UserProject.new
    assert !@user_project.save
  end

  def test_creating_duplicated
    @user_project = UserProject.new({:user_id => 1, :project_id => 1, :roleinproject_id => 3 })
    assert !@user_project.save
  end

  # Boundary
  def test_bad_values_for_id
    @myuser_project.id = 1.6
    assert !@myuser_project.valid?
    @myuser_project.id = 'mi_id'
    assert !@myuser_project.valid?
  end

  def test_bad_values_for_user_id
    @myuser_project.user_id= 1.6
    assert !@myuser_project.valid?
    @myuser_project.user_id = 'mi_id_texto'
    assert !@myuser_project.valid?
  end

  def test_bad_values_for_project_id
    @myuser_project.project_id = nil
    assert !@myuser_project.valid?
    @myuser_project.project_id = 1.6
    assert !@myuser_project.valid?
    @myuser_project.project_id = 'mi_id_texto'
    assert !@myuser_project.valid?
  end

  def test_bad_values_for_roleinproject_id
    @myuser_project.roleinproject_id = nil
    assert !@myuser_project.valid?
    @myuser_project.roleinproject_id = 1.6
    assert !@myuser_project.valid?
    @myuser_project.roleinproject_id = 'mi_id_texto'
    assert !@myuser_project.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_projects.each { | user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_kind_of UserProject, @user_project
      assert_equal @user_project.user_id, User.find(@user_project.user_id).id
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
    @user_projects.each { | user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_kind_of UserProject, @user_project
      @user_project.user_id = 5
      begin
        return true if @user_project.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for project
  def test_cross_checking_for_project_id
    @user_projects.each { | user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_kind_of UserProject, @user_project
      assert_equal @user_project.project_id, Project.find(@user_project.project_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_project_id
    @user_projects.each { | user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_kind_of UserProject, @user_project
      @user_project.project_id = 1000000
      begin
        return true if @user_project.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for roleinproject
  def test_cross_checking_for_project_id
    @user_projects.each { | user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_kind_of UserProject, @user_project
      assert_equal @user_project.roleinproject_id, Roleinproject.find(@user_project.roleinproject_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_project_id
    @user_projects.each { | user_project|
      @user_project = UserProject.find(user_projects(user_project.to_sym).id)
      assert_kind_of UserProject, @user_project
      @user_project.roleinproject_id = 1000000
      begin
        return true if @user_project.save
      rescue StandardError => x
        return false
      end
    }
  end

end
