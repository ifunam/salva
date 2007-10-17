require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'thesis'
require 'projectthesis'

class ProjectthesisTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses,:projects, :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :thesismodalities, :thesisstatuses, :theses, :projecttheses

  def setup
    @projecttheses = %w(administracion_publica_en_la_unam eventos_economico_sociales_en_mexico)
    @myprojectthesis = Projectthesis.new({:project_id => 2, :thesis_id => 1})
  end

  # Right - CRUD
  def test_creating_projectthesis_from_yaml
    @projecttheses.each { | projectthesis|
      @projectthesis = Projectthesis.find(projecttheses(projectthesis.to_sym).id)
      assert_kind_of Projectthesis, @projectthesis
      assert_equal projecttheses(projectthesis.to_sym).id, @projectthesis.id
      assert_equal projecttheses(projectthesis.to_sym).project_id, @projectthesis.project_id
      assert_equal projecttheses(projectthesis.to_sym).thesis_id, @projectthesis.thesis_id
    }
  end

  def test_updating_project_id
    @projecttheses.each { |projectthesis|
      @projectthesis = Projectthesis.find(projecttheses(projectthesis.to_sym).id)
      assert_equal projecttheses(projectthesis.to_sym).project_id, @projectthesis.project_id
      @projectthesis.project_id = 1
      assert @projectthesis.save
      assert_not_equal projecttheses(projectthesis.to_sym).project_id, @projectthesis.project_id
    }
  end

  def test_updating_thesis_id
    @projecttheses.each { |projectthesis|
      @projectthesis = Projectthesis.find(projecttheses(projectthesis.to_sym).id)
      assert_equal projecttheses(projectthesis.to_sym).thesis_id, @projectthesis.thesis_id
      @projectthesis.thesis_id == 1 ? @projectthesis.thesis_id = @projectthesis.thesis_id + 1 : @projectthesis.thesis_id = @projectthesis.thesis_id - 1
      assert @projectthesis.save
      assert_not_equal projecttheses(projectthesis.to_sym).thesis_id, @projectthesis.thesis_id
    }
  end

  def test_creating_with_empty_attributes
    @projectthesis = Projectthesis.new
    assert !@projectthesis.save
  end

  def test_creating_duplicated
    @projectthesis = Projectthesis.new({:project_id => 2, :thesis_id => 1})
    assert !@projectthesis.save
  end

  # Boundary
  def test_bad_values_for_id
    @myprojectthesis.id = 1.6
    assert !@myprojectthesis.valid?
    @myprojectthesis.id = 'mi_id'
    assert !@myprojectthesis.valid?
    @myprojectthesis.id = -1.0
    assert !@myprojectthesis.valid?
  end

  def test_bad_values_for_project_id
    @myprojectthesis.project_id = nil
    assert !@myprojectthesis.valid?
    @myprojectthesis.project_id= 1.6
    assert !@myprojectthesis.valid?
    @myprojectthesis.project_id = 'mi_id_texto'
    assert !@myprojectthesis.valid?
    @myprojectthesis.project_id= -1.0
    assert !@myprojectthesis.valid?
  end

  def test_bad_values_for_thesis_id
    @myprojectthesis.thesis_id = nil
    assert !@myprojectthesis.valid?
    @myprojectthesis.thesis_id = 1.6
    assert !@myprojectthesis.valid?
    @myprojectthesis.thesis_id = 'mi_id_texto'
    assert !@myprojectthesis.valid?
    @myprojectthesis.thesis_id = -1.0
    assert !@myprojectthesis.valid?
  end

  #cross check for project
  def test_cross_checking_for_project_id
    @projecttheses.each { | projectthesis|
      @projectthesis = Projectthesis.find(projecttheses(projectthesis.to_sym).id)
      assert_kind_of Projectthesis, @projectthesis
      assert_equal @projectthesis.project_id, Project.find(@projectthesis.project_id).id
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
    @projecttheses.each { | projectthesis|
      @projectthesis = Projectthesis.find(projecttheses(projectthesis.to_sym).id)
      assert_kind_of Projectthesis, @projectthesis
      @projectthesis.project_id = 50
      begin
        return true if @projectthesis.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for thesis
  def test_cross_checking_for_thesis_id
    @projecttheses.each { | projectthesis|
      @projectthesis = Projectthesis.find(projecttheses(projectthesis.to_sym).id)
      assert_kind_of Projectthesis, @projectthesis
      assert_equal @projectthesis.thesis_id, Project.find(@projectthesis.thesis_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_thesis_id
    @projecttheses.each { | projectthesis|
      @projectthesis = Projectthesis.find(projecttheses(projectthesis.to_sym).id)
      assert_kind_of Projectthesis, @projectthesis
      @projectthesis.thesis_id = 50
      begin
        return true if @projectthesis.save
      rescue StandardError => x
        return false
      end
    }
  end
end
