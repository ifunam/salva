require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'institution'
require 'projectfinancingsource'

class ProjectfinancingsourceTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects, :countries,  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :projectfinancingsources

  def setup
    @projectfinancingsources = %w(financiamiento_salva financiamiento_issste financiamiento_seguridad_publica)
    @myprojectfinancingsource = Projectfinancingsource.new({:project_id => 2, :institution_id => 1, :amount => 95000})
  end

  # Right - CRUD
  def test_creating_projectfinancingsources_from_yaml
    @projectfinancingsources.each { | projectfinancingsource|
      @projectfinancingsource = Projectfinancingsource.find(projectfinancingsources(projectfinancingsource.to_sym).id)
      assert_kind_of Projectfinancingsource, @projectfinancingsource
      assert_equal projectfinancingsources(projectfinancingsource.to_sym).id, @projectfinancingsource.id
      assert_equal projectfinancingsources(projectfinancingsource.to_sym).institution_id, @projectfinancingsource.institution_id
      assert_equal projectfinancingsources(projectfinancingsource.to_sym).project_id, @projectfinancingsource.project_id
    }
  end

  def test_deleting_projectfinancingsources
    @projectfinancingsources.each { |projectfinancingsource|
      @projectfinancingsource = Projectfinancingsource.find(projectfinancingsources(projectfinancingsource.to_sym).id)
      @projectfinancingsource.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectfinancingsource.find(projectfinancingsources(projectfinancingsource.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectfinancingsource = Projectfinancingsource.new
    assert !@projectfinancingsource.save
  end

  def test_creating_duplicated_projectfinancingsource
    @projectfinancingsource = Projectfinancingsource.new({:project_id => 3, :institution_id => 57, :amount => 65700})
    assert !@projectfinancingsource.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectfinancingsource.id = 1.6
    assert !@myprojectfinancingsource.valid?

    @myprojectfinancingsource.id = 'mi_id'
    assert !@myprojectfinancingsource.valid?

    @myprojectfinancingsource.id = -1.0
    assert !@myprojectfinancingsource.valid?
  end

  def test_bad_values_for_institution_id
    @myprojectfinancingsource.institution_id = nil
    assert !@myprojectfinancingsource.valid?

    @myprojectfinancingsource.institution_id= 1.6
    assert !@myprojectfinancingsource.valid?

    @myprojectfinancingsource.institution_id = 'mi_id'
    assert !@myprojectfinancingsource.valid?

    @myprojectfinancingsource.institution_id = -1.0
    assert !@myprojectfinancingsource.valid?
  end

  def test_bad_values_for_project_id
    @myprojectfinancingsource.project_id = nil
    assert !@myprojectfinancingsource.valid?

    @myprojectfinancingsource.project_id = 3.1416
    assert !@myprojectfinancingsource.valid?

    @myprojectfinancingsource.project_id = 'mi_id'
    assert !@myprojectfinancingsource.valid?

    @myprojectfinancingsource.project_id = -1.0
    assert !@myprojectfinancingsource.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectfinancingsources.each { | projectfinancingsource|
      @projectfinancingsource = Projectfinancingsource.find(projectfinancingsources(projectfinancingsource.to_sym).id)
      assert_kind_of Projectfinancingsource, @projectfinancingsource
      assert_equal @projectfinancingsource.project_id, Project.find(@projectfinancingsource.project_id).id
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
    @projectfinancingsources.each { | projectfinancingsource|
      @projectfinancingsource = Projectfinancingsource.find(projectfinancingsources(projectfinancingsource.to_sym).id)
      assert_kind_of Projectfinancingsource, @projectfinancingsource
      @projectfinancingsource.project_id = 1000000
      begin
        return true if @projectfinancingsource.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_institution_id
    @projectfinancingsources.each { | projectfinancingsource|
      @projectfinancingsource = Projectfinancingsource.find(projectfinancingsources(projectfinancingsource.to_sym).id)

      assert_kind_of Projectfinancingsource, @projectfinancingsource
      assert_equal @projectfinancingsource.institution_id, Institution.find(@projectfinancingsource.institution_id).id
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
    @projectfinancingsources.each { | projectfinancingsource|
      @projectfinancingsource = Projectfinancingsource.find(projectfinancingsources(projectfinancingsource.to_sym).id)
      assert_kind_of Projectfinancingsource, @projectfinancingsource
      @projectfinancingsource.institution_id = 100000
      begin
        return true if @projectfinancingsource.save
      rescue StandardError => x
        return false
      end
    }
  end

end
