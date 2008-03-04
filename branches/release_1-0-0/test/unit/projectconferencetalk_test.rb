require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'conferencetalk'
require 'projectconferencetalk'

class ProjectconferencetalkTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects, :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :conferences, :talktypes, :talkacceptances, :modalities, :conferencetalks, :projectconferencetalks

  def setup
    @projectconferencetalks = %w(formacion_de_barrancos_en_marte formacion_de_suelos_volcanicos)
    @myprojectconferencetalk = Projectconferencetalk.new({:project_id => 2, :conferencetalk_id => 2})
  end

  # Right - CRUD
  def test_creating_projectconferencetalks_from_yaml
    @projectconferencetalks.each { | projectconferencetalk|
      @projectconferencetalk = Projectconferencetalk.find(projectconferencetalks(projectconferencetalk.to_sym).id)
      assert_kind_of Projectconferencetalk, @projectconferencetalk
      assert_equal projectconferencetalks(projectconferencetalk.to_sym).id, @projectconferencetalk.id
      assert_equal projectconferencetalks(projectconferencetalk.to_sym).conferencetalk_id, @projectconferencetalk.conferencetalk_id
      assert_equal projectconferencetalks(projectconferencetalk.to_sym).project_id, @projectconferencetalk.project_id
    }
  end

  def test_deleting_projectconferencetalks
    @projectconferencetalks.each { |projectconferencetalk|
      @projectconferencetalk = Projectconferencetalk.find(projectconferencetalks(projectconferencetalk.to_sym).id)
      @projectconferencetalk.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectconferencetalk.find(projectconferencetalks(projectconferencetalk.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectconferencetalk = Projectconferencetalk.new
    assert !@projectconferencetalk.save
  end

  def test_creating_duplicated_projectconferencetalk
    @projectconferencetalk = Projectconferencetalk.new({:project_id => 3, :conferencetalk_id => 2})
    assert !@projectconferencetalk.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectconferencetalk.id = 1.6
    assert !@myprojectconferencetalk.valid?
    @myprojectconferencetalk.id = 'mi_id'
    assert !@myprojectconferencetalk.valid?
  end

  def test_bad_values_for_conferencetalk_id
#     @myprojectconferencetalk.conferencetalk_id = nil
#     assert !@myprojectconferencetalk.valid?

    @myprojectconferencetalk.conferencetalk_id= 1.6
    assert !@myprojectconferencetalk.valid?

    @myprojectconferencetalk.conferencetalk_id = 'mi_id'
    assert !@myprojectconferencetalk.valid?
  end

  def test_bad_values_for_project_id
    @myprojectconferencetalk.project_id = nil
    assert !@myprojectconferencetalk.valid?

    @myprojectconferencetalk.project_id = 3.1416
    assert !@myprojectconferencetalk.valid?
    @myprojectconferencetalk.project_id = 'mi_id'
    assert !@myprojectconferencetalk.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectconferencetalks.each { | projectconferencetalk|
      @projectconferencetalk = Projectconferencetalk.find(projectconferencetalks(projectconferencetalk.to_sym).id)
      assert_kind_of Projectconferencetalk, @projectconferencetalk
      assert_equal @projectconferencetalk.project_id, Project.find(@projectconferencetalk.project_id).id
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
    @projectconferencetalks.each { | projectconferencetalk|
      @projectconferencetalk = Projectconferencetalk.find(projectconferencetalks(projectconferencetalk.to_sym).id)
      assert_kind_of Projectconferencetalk, @projectconferencetalk
      @projectconferencetalk.project_id = 1000000
      begin
        return true if @projectconferencetalk.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_conferencetalk_id
    @projectconferencetalks.each { | projectconferencetalk|
      @projectconferencetalk = Projectconferencetalk.find(projectconferencetalks(projectconferencetalk.to_sym).id)

      assert_kind_of Projectconferencetalk, @projectconferencetalk
      assert_equal @projectconferencetalk.conferencetalk_id, Conferencetalk.find(@projectconferencetalk.conferencetalk_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_conferencetalk_id
    @projectconferencetalks.each { | projectconferencetalk|
      @projectconferencetalk = Projectconferencetalk.find(projectconferencetalks(projectconferencetalk.to_sym).id)
      assert_kind_of Projectconferencetalk, @projectconferencetalk
      @projectconferencetalk.conferencetalk_id = 100000
      begin
        return true if @projectconferencetalk.save
      rescue StandardError => x
        return false
      end
    }
  end

end
