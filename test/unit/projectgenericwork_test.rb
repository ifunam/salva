require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'genericwork'
require 'projectgenericwork'

class ProjectgenericworkTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects, :genericworkstatuses, :genericworkgroups, :genericworktypes, :genericworks, :projectgenericworks

  def setup
    @projectgenericworks = %w(radiotelescopio_de_centelleo_interplanetario_comunicaciones_tecnicas los_barrancos_en_marte_reportes_tecnicos)
    @myprojectgenericwork = Projectgenericwork.new({:project_id => 3, :genericwork_id => 1})
  end

  # Right - CRUD
  def test_creating_projectgenericworks_from_yaml
    @projectgenericworks.each { | projectgenericwork|
      @projectgenericwork = Projectgenericwork.find(projectgenericworks(projectgenericwork.to_sym).id)
      assert_kind_of Projectgenericwork, @projectgenericwork
      assert_equal projectgenericworks(projectgenericwork.to_sym).id, @projectgenericwork.id
      assert_equal projectgenericworks(projectgenericwork.to_sym).genericwork_id, @projectgenericwork.genericwork_id
      assert_equal projectgenericworks(projectgenericwork.to_sym).project_id, @projectgenericwork.project_id
    }
  end

  def test_deleting_projectgenericworks
    @projectgenericworks.each { |projectgenericwork|
      @projectgenericwork = Projectgenericwork.find(projectgenericworks(projectgenericwork.to_sym).id)
      @projectgenericwork.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectgenericwork.find(projectgenericworks(projectgenericwork.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectgenericwork = Projectgenericwork.new
    assert !@projectgenericwork.save
  end

  def test_creating_duplicated_projectgenericwork
    @projectgenericwork = Projectgenericwork.new({:project_id => 2, :genericwork_id => 1})
    assert !@projectgenericwork.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectgenericwork.id = 1.6
    assert !@myprojectgenericwork.valid?
    @myprojectgenericwork.id = 'mi_id'
    assert !@myprojectgenericwork.valid?
    @myprojectgenericwork.id = -1.0
    assert !@myprojectgenericwork.valid?
  end

  def test_bad_values_for_genericwork_id
    @myprojectgenericwork.genericwork_id = nil
    assert !@myprojectgenericwork.valid?

    @myprojectgenericwork.genericwork_id= 1.6
    assert !@myprojectgenericwork.valid?

    @myprojectgenericwork.genericwork_id = 'mi_id'
    assert !@myprojectgenericwork.valid?

    @myprojectgenericwork.genericwork_id= -1.0
    assert !@myprojectgenericwork.valid?
  end

  def test_bad_values_for_project_id
    @myprojectgenericwork.project_id = nil
    assert !@myprojectgenericwork.valid?

    @myprojectgenericwork.project_id = 3.1416
    assert !@myprojectgenericwork.valid?

    @myprojectgenericwork.project_id = 'mi_id'
    assert !@myprojectgenericwork.valid?

    @myprojectgenericwork.project_id = -3.0
    assert !@myprojectgenericwork.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectgenericworks.each { | projectgenericwork|
      @projectgenericwork = Projectgenericwork.find(projectgenericworks(projectgenericwork.to_sym).id)
      assert_kind_of Projectgenericwork, @projectgenericwork
      assert_equal @projectgenericwork.project_id, Project.find(@projectgenericwork.project_id).id
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
    @projectgenericworks.each { | projectgenericwork|
      @projectgenericwork = Projectgenericwork.find(projectgenericworks(projectgenericwork.to_sym).id)
      assert_kind_of Projectgenericwork, @projectgenericwork
      @projectgenericwork.project_id = 1000000
      begin
        return true if @projectgenericwork.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_genericwork_id
    @projectgenericworks.each { | projectgenericwork|
      @projectgenericwork = Projectgenericwork.find(projectgenericworks(projectgenericwork.to_sym).id)

      assert_kind_of Projectgenericwork, @projectgenericwork
      assert_equal @projectgenericwork.genericwork_id, Genericwork.find(@projectgenericwork.genericwork_id).id
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
    @projectgenericworks.each { | projectgenericwork|
      @projectgenericwork = Projectgenericwork.find(projectgenericworks(projectgenericwork.to_sym).id)
      assert_kind_of Projectgenericwork, @projectgenericwork
      @projectgenericwork.genericwork_id = 100000
      begin
        return true if @projectgenericwork.save
      rescue StandardError => x
        return false
      end
    }
  end

end
