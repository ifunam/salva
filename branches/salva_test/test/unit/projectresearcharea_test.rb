require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'researcharea'
require 'projectresearcharea'

class ProjectresearchareaTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects, :researchareas, :projectresearchareas

  def setup
    @projectresearchareas = %w(proyecto_area_salva proyecto_area_issste proyecto_area_issste_2)
    @myprojectresearcharea = Projectresearcharea.new({:project_id => 2, :researcharea_id => 1})
  end

  # Right - CRUD
  def test_creating_projectresearchareas_from_yaml
    @projectresearchareas.each { | projectresearcharea|
      @projectresearcharea = Projectresearcharea.find(projectresearchareas(projectresearcharea.to_sym).id)
      assert_kind_of Projectresearcharea, @projectresearcharea
      assert_equal projectresearchareas(projectresearcharea.to_sym).id, @projectresearcharea.id
      assert_equal projectresearchareas(projectresearcharea.to_sym).researcharea_id, @projectresearcharea.researcharea_id
      assert_equal projectresearchareas(projectresearcharea.to_sym).project_id, @projectresearcharea.project_id
    }
  end

  def test_deleting_projectresearchareas
    @projectresearchareas.each { |projectresearcharea|
      @projectresearcharea = Projectresearcharea.find(projectresearchareas(projectresearcharea.to_sym).id)
      @projectresearcharea.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectresearcharea.find(projectresearchareas(projectresearcharea.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectresearcharea = Projectresearcharea.new
    assert !@projectresearcharea.save
  end

  def test_creating_duplicated_projectresearcharea
    @projectresearcharea = Projectresearcharea.new({:project_id => 2, :researcharea_id => 3})
    assert !@projectresearcharea.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectresearcharea.id = 1.6
    assert !@myprojectresearcharea.valid?
    @myprojectresearcharea.id = 'mi_id'
    assert !@myprojectresearcharea.valid?
  end

  def test_bad_values_for_researcharea_id
    @myprojectresearcharea.researcharea_id = nil
    assert !@myprojectresearcharea.valid?

    @myprojectresearcharea.researcharea_id= 1.6
    assert !@myprojectresearcharea.valid?

    @myprojectresearcharea.researcharea_id = 'mi_id'
    assert !@myprojectresearcharea.valid?
  end

  def test_bad_values_for_project_id
    @myprojectresearcharea.project_id = nil
    assert !@myprojectresearcharea.valid?

    @myprojectresearcharea.project_id = 3.1416
    assert !@myprojectresearcharea.valid?
    @myprojectresearcharea.project_id = 'mi_id'
    assert !@myprojectresearcharea.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectresearchareas.each { | projectresearcharea|
      @projectresearcharea = Projectresearcharea.find(projectresearchareas(projectresearcharea.to_sym).id)
      assert_kind_of Projectresearcharea, @projectresearcharea
      assert_equal @projectresearcharea.project_id, Project.find(@projectresearcharea.project_id).id
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
    @projectresearchareas.each { | projectresearcharea|
      @projectresearcharea = Projectresearcharea.find(projectresearchareas(projectresearcharea.to_sym).id)
      assert_kind_of Projectresearcharea, @projectresearcharea
      @projectresearcharea.project_id = 1000000
      begin
        return true if @projectresearcharea.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_researcharea_id
    @projectresearchareas.each { | projectresearcharea|
      @projectresearcharea = Projectresearcharea.find(projectresearchareas(projectresearcharea.to_sym).id)

      assert_kind_of Projectresearcharea, @projectresearcharea
      assert_equal @projectresearcharea.researcharea_id, Researcharea.find(@projectresearcharea.researcharea_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_researcharea_id
    @projectresearchareas.each { | projectresearcharea|
      @projectresearcharea = Projectresearcharea.find(projectresearchareas(projectresearcharea.to_sym).id)
      assert_kind_of Projectresearcharea, @projectresearcharea
      @projectresearcharea.researcharea_id = 100000
      begin
        return true if @projectresearcharea.save
      rescue StandardError => x
        return false
      end
    }
  end

end
