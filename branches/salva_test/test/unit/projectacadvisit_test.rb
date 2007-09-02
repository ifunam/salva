require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'acadvisit'
require 'projectacadvisit'

class ProjectacadvisitTest < Test::Unit::TestCase
  fixtures :countries, :newspapers, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :userstatuses, :users, :projecttypes, :projectstatuses, :projects, :externalusers, :acadvisittypes, :acadvisits, :projectacadvisits

  def setup
    @projectacadvisits = %w(estudios_ambientales_en_latutudes_altas estudios_sobre_aguas_marinas_contaminadas)
    @myprojectacadvisit = Projectacadvisit.new({:project_id => 1, :acadvisit_id => 2})
  end

  # Right - CRUD
  def test_creating_projectacadvisits_from_yaml
    @projectacadvisits.each { | projectacadvisit|
      @projectacadvisit = Projectacadvisit.find(projectacadvisits(projectacadvisit.to_sym).id)
      assert_kind_of Projectacadvisit, @projectacadvisit
      assert_equal projectacadvisits(projectacadvisit.to_sym).id, @projectacadvisit.id
      assert_equal projectacadvisits(projectacadvisit.to_sym).acadvisit_id, @projectacadvisit.acadvisit_id
      assert_equal projectacadvisits(projectacadvisit.to_sym).project_id, @projectacadvisit.project_id
    }
  end

  def test_deleting_projectacadvisits
    @projectacadvisits.each { |projectacadvisit|
      @projectacadvisit = Projectacadvisit.find(projectacadvisits(projectacadvisit.to_sym).id)
      @projectacadvisit.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectacadvisit.find(projectacadvisits(projectacadvisit.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectacadvisit = Projectacadvisit.new
    assert !@projectacadvisit.save
  end

  def test_creating_duplicated_projectacadvisit
    @projectacadvisit = Projectacadvisit.new({:project_id => 2, :acadvisit_id => 2})
    assert !@projectacadvisit.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectacadvisit.id = 1.6
    assert !@myprojectacadvisit.valid?
    @myprojectacadvisit.id = 'mi_id'
    assert !@myprojectacadvisit.valid?
  end

  def test_bad_values_for_acadvisit_id
    @myprojectacadvisit.acadvisit_id = nil
    assert !@myprojectacadvisit.valid?

    @myprojectacadvisit.acadvisit_id= 1.6
    assert !@myprojectacadvisit.valid?

    @myprojectacadvisit.acadvisit_id = 'mi_id'
    assert !@myprojectacadvisit.valid?
  end

  def test_bad_values_for_project_id
    @myprojectacadvisit.project_id = nil
    assert !@myprojectacadvisit.valid?

    @myprojectacadvisit.project_id = 3.1416
    assert !@myprojectacadvisit.valid?
    @myprojectacadvisit.project_id = 'mi_id'
    assert !@myprojectacadvisit.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_project_id
    @projectacadvisits.each { | projectacadvisit|
      @projectacadvisit = Projectacadvisit.find(projectacadvisits(projectacadvisit.to_sym).id)
      assert_kind_of Projectacadvisit, @projectacadvisit
      assert_equal @projectacadvisit.project_id, Project.find(@projectacadvisit.project_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_project_id
    @projectacadvisits.each { | projectacadvisit|
      @projectacadvisit = Projectacadvisit.find(projectacadvisits(projectacadvisit.to_sym).id)
      assert_kind_of Projectacadvisit, @projectacadvisit
      @projectacadvisit.project_id = 1000000
      begin
        return true if @projectacadvisit.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_acadvisit_id
    @projectacadvisits.each { | projectacadvisit|
      @projectacadvisit = Projectacadvisit.find(projectacadvisits(projectacadvisit.to_sym).id)

      assert_kind_of Projectacadvisit, @projectacadvisit
      assert_equal @projectacadvisit.acadvisit_id, Acadvisit.find(@projectacadvisit.acadvisit_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_acadvisit_id
    @projectacadvisits.each { | projectacadvisit|
      @projectacadvisit = Projectacadvisit.find(projectacadvisits(projectacadvisit.to_sym).id)
      assert_kind_of Projectacadvisit, @projectacadvisit
      @projectacadvisit.acadvisit_id = 100000
      begin
        return true if @projectacadvisit.update
      rescue StandardError => x
        return false
      end
    }
  end

end