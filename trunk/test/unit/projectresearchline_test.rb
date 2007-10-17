require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'researchline'
require 'projectresearchline'

class ProjectresearchlineTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects, :researchareas , :researchlines, :projectresearchlines

  def setup
    @projectresearchlines = %w(linea_investigacion_salva linea_investigacion_issste linea_investigacion_seguridad_publica)
    @myprojectresearchline = Projectresearchline.new({:project_id => 2, :researchline_id => 1})
  end

  # Right - CRUD
  def test_creating_projectresearchlines_from_yaml
    @projectresearchlines.each { | projectresearchline|
      @projectresearchline = Projectresearchline.find(projectresearchlines(projectresearchline.to_sym).id)
      assert_kind_of Projectresearchline, @projectresearchline
      assert_equal projectresearchlines(projectresearchline.to_sym).id, @projectresearchline.id
      assert_equal projectresearchlines(projectresearchline.to_sym).researchline_id, @projectresearchline.researchline_id
      assert_equal projectresearchlines(projectresearchline.to_sym).project_id, @projectresearchline.project_id
    }
  end

  def test_deleting_projectresearchlines
    @projectresearchlines.each { |projectresearchline|
      @projectresearchline = Projectresearchline.find(projectresearchlines(projectresearchline.to_sym).id)
      @projectresearchline.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectresearchline.find(projectresearchlines(projectresearchline.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectresearchline = Projectresearchline.new
    assert !@projectresearchline.save
  end

  def test_creating_duplicated_projectresearchline
    @projectresearchline = Projectresearchline.new({:project_id => 2, :researchline_id => 2})
    assert !@projectresearchline.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectresearchline.id = 1.6
    assert !@myprojectresearchline.valid?
    @myprojectresearchline.id = 'mi_id'
    assert !@myprojectresearchline.valid?
  end

  def test_bad_values_for_researchline_id
    @myprojectresearchline.researchline_id = nil
    assert !@myprojectresearchline.valid?

    @myprojectresearchline.researchline_id= 1.6
    assert !@myprojectresearchline.valid?

    @myprojectresearchline.researchline_id = 'mi_id'
    assert !@myprojectresearchline.valid?
  end

  def test_bad_values_for_project_id
    @myprojectresearchline.project_id = nil
    assert !@myprojectresearchline.valid?

    @myprojectresearchline.project_id = 3.1416
    assert !@myprojectresearchline.valid?
    @myprojectresearchline.project_id = 'mi_id'
    assert !@myprojectresearchline.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectresearchlines.each { | projectresearchline|
      @projectresearchline = Projectresearchline.find(projectresearchlines(projectresearchline.to_sym).id)
      assert_kind_of Projectresearchline, @projectresearchline
      assert_equal @projectresearchline.project_id, Project.find(@projectresearchline.project_id).id
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
    @projectresearchlines.each { | projectresearchline|
      @projectresearchline = Projectresearchline.find(projectresearchlines(projectresearchline.to_sym).id)
      assert_kind_of Projectresearchline, @projectresearchline
      @projectresearchline.project_id = 1000000
      begin
        return true if @projectresearchline.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_researchline_id
    @projectresearchlines.each { | projectresearchline|
      @projectresearchline = Projectresearchline.find(projectresearchlines(projectresearchline.to_sym).id)

      assert_kind_of Projectresearchline, @projectresearchline
      assert_equal @projectresearchline.researchline_id, Researchline.find(@projectresearchline.researchline_id).id
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
    @projectresearchlines.each { | projectresearchline|
      @projectresearchline = Projectresearchline.find(projectresearchlines(projectresearchline.to_sym).id)
      assert_kind_of Projectresearchline, @projectresearchline
      @projectresearchline.researchline_id = 100000
      begin
        return true if @projectresearchline.save
      rescue StandardError => x
        return false
      end
    }
  end

end
