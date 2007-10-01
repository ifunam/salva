require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'institution'
require 'projectinstitution'

class ProjectinstitutionTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects, :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :projectinstitutions

  def setup
    @projectinstitutions = %w(proyecto_instituciones_salva proyecto_instituciones_issste)
    @myprojectinstitution = Projectinstitution.new({:project_id => 3, :institution_id => 5588})
  end

  # Right - CRUD
  def test_creating_projectinstitutions_from_yaml
    @projectinstitutions.each { | projectinstitution|
      @projectinstitution = Projectinstitution.find(projectinstitutions(projectinstitution.to_sym).id)
      assert_kind_of Projectinstitution, @projectinstitution
      assert_equal projectinstitutions(projectinstitution.to_sym).id, @projectinstitution.id
      assert_equal projectinstitutions(projectinstitution.to_sym).institution_id, @projectinstitution.institution_id
      assert_equal projectinstitutions(projectinstitution.to_sym).project_id, @projectinstitution.project_id
    }
  end

  def test_deleting_projectinstitutions
    @projectinstitutions.each { |projectinstitution|
      @projectinstitution = Projectinstitution.find(projectinstitutions(projectinstitution.to_sym).id)
      @projectinstitution.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectinstitution.find(projectinstitutions(projectinstitution.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectinstitution = Projectinstitution.new
    assert !@projectinstitution.save
  end

  def test_creating_duplicated_projectinstitution
    @projectinstitution = Projectinstitution.new({:project_id => 2, :institution_id => 57})
    assert !@projectinstitution.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectinstitution.id = 1.6
    assert !@myprojectinstitution.valid?
    @myprojectinstitution.id = 'mi_id'
    assert !@myprojectinstitution.valid?
  end

  def test_bad_values_for_institution_id
    @myprojectinstitution.institution_id = nil
    assert !@myprojectinstitution.valid?

    @myprojectinstitution.institution_id= 1.6
    assert !@myprojectinstitution.valid?

    @myprojectinstitution.institution_id = 'mi_id'
    assert !@myprojectinstitution.valid?
  end

  def test_bad_values_for_project_id
    @myprojectinstitution.project_id = nil
    assert !@myprojectinstitution.valid?

    @myprojectinstitution.project_id = 3.1416
    assert !@myprojectinstitution.valid?
    @myprojectinstitution.project_id = 'mi_id'
    assert !@myprojectinstitution.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectinstitutions.each { | projectinstitution|
      @projectinstitution = Projectinstitution.find(projectinstitutions(projectinstitution.to_sym).id)
      assert_kind_of Projectinstitution, @projectinstitution
      assert_equal @projectinstitution.project_id, Project.find(@projectinstitution.project_id).id
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
    @projectinstitutions.each { | projectinstitution|
      @projectinstitution = Projectinstitution.find(projectinstitutions(projectinstitution.to_sym).id)
      assert_kind_of Projectinstitution, @projectinstitution
      @projectinstitution.project_id = 1000000
      begin
        return true if @projectinstitution.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_institution_id
    @projectinstitutions.each { | projectinstitution|
      @projectinstitution = Projectinstitution.find(projectinstitutions(projectinstitution.to_sym).id)

      assert_kind_of Projectinstitution, @projectinstitution
      assert_equal @projectinstitution.institution_id, Institution.find(@projectinstitution.institution_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institution_id
    @projectinstitutions.each { | projectinstitution|
      @projectinstitution = Projectinstitution.find(projectinstitutions(projectinstitution.to_sym).id)
      assert_kind_of Projectinstitution, @projectinstitution
      @projectinstitution.institution_id = 100000
      begin
        return true if @projectinstitution.save
      rescue StandardError => x
        return false
      end
    }
  end

end
