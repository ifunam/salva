require File.dirname(__FILE__) + '/../test_helper'
require 'project'

class ProjectTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses,:projects

  def setup
    @projects = %w(salva ley_del_issste seguridad_publica)
    @myproject = Project.new({:name => 'salva2', :projecttype_id => 3, :projectstatus_id =>1, :descr => 'sistema curricular', :responsible => 'Armando Manzanero', :startyear => 2007})
  end

  # Right - CRUD
  def test_creating_projects_from_yaml
    @projects.each { | project|
      @project = Project.find(projects(project.to_sym).id)
      assert_kind_of Project, @project
      assert_equal projects(project.to_sym).id, @project.id
      assert_equal projects(project.to_sym).name, @project.name
      assert_equal projects(project.to_sym).projecttype_id, @project.projecttype_id
      assert_equal projects(project.to_sym).projectstatus_id, @project.projectstatus_id
      assert_equal projects(project.to_sym).descr, @project.descr
      assert_equal projects(project.to_sym).responsible, @project.responsible
      assert_equal projects(project.to_sym).startyear, @project.startyear
    }
  end

  def test_updating_projects_name
    @projects.each { |project|
      @project = Project.find(projects(project.to_sym).id)
      assert_equal projects(project.to_sym).name, @project.name
      @project.name = @project.name.chars.reverse
      assert @project.save
      assert_not_equal projects(project.to_sym).name, @project.name
    }
  end

  def test_deleting_projects
    @projects.each { |project|
      @project = Project.find(projects(project.to_sym).id)
      @project.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Project.find(projects(project.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @project = Project.new
    assert !@project.save
  end

  def test_creating_duplicated_project
    @project = Project.new(({:name => 'Salva', :responsible => 'Israel Casanova', :descr => 'Sistema curricular', :projecttype_id => 1, :projectstatus_id =>2, :startyear => 2007}))
    @project.id = 1
    assert !@project.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myproject.id = 1.6
    assert !@myproject.valid?

    @myproject.id = 'xx'
    assert !@myproject.valid?

    # Negative numbers
    # @myproject.id = -1
    # assert !@myproject.valid?
  end

  def test_bad_values_for_name
    @myproject.name = nil
    assert !@myproject.valid?
  end

  def test_bad_values_for_projecttype_id
    # Checking constraints for name
    # Nil name
    @myproject.projecttype_id = nil
    assert !@myproject.valid?

    # Float number for ID
    @myproject.projecttype_id = 3.1416
    assert !@myproject.valid?

    # Negative numbers
    # @myproject.projecttype_id = -1
    # assert !@myproject.valid?
  end


  def test_bad_values_for_projectstatus_id
    # Checking constraints for name
    # Nil name
    @myproject.projectstatus_id = nil
    assert !@myproject.valid?

    # Float number for ID
    @myproject.projectstatus_id = 3.1416
    assert !@myproject.valid?

    # Negative numbers
    #      @myproject.projectstatus_id = -1
    #      assert !@myproject.valid?
  end



  #Cross-Checking test


  def test_cross_checking_for_projecttype_id
    @projects.each { | project|
      @project = Project.find(projects(project.to_sym).id)
      assert_kind_of Project, @project
      assert_equal @project.projecttype_id, Projecttype.find(@project.projecttype_id).id
    }
  end

  def test_cross_checking_with_bad_values_for_projecttype_id
    @projects.each { | project|
      @project = Project.find(projects(project.to_sym).id)
      assert_kind_of Project, @project
      @project.projecttype_id = 108
      begin
        return true if @project.save
      rescue StandardError => x
        return false
      end
    }
  end


  def test_cross_checking_for_projectstatus_id
    @projects.each { | project|
      @project = Project.find(projects(project.to_sym).id)
      assert_kind_of Project, @project
      assert_equal @project.projectstatus_id, Projectstatus.find(@project.projectstatus_id).id
    }
  end

  def test_cross_checking_with_bad_values_for_projectstatus_id
    @projects.each { | project|
      @project = Project.find(projects(project.to_sym).id)
      assert_kind_of Project, @project
      @project.projectstatus_id = 108
      begin
        return true if @project.save
      rescue StandardError => x
        return false
      end
    }
  end


end

