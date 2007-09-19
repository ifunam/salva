require File.dirname(__FILE__) + '/../test_helper'
require 'degree'
require 'institutioncareer'
require 'user'
require 'tutorial_committee'

class TutorialCommitteeTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :degrees, :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :tutorial_committees

  def setup
    @tutorial_committees = %w(tutor jurado)
    @mytutorial_committee = TutorialCommittee.new({:user_id => 1, :studentname => 'Jose Luis Benitez', :degree_id => 4, :institutioncareer_id => 1, :year => 2005 })
  end

  # Right - CRUD
  def test_creating_tutorial_committee_from_yaml
    @tutorial_committees.each { | tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_kind_of TutorialCommittee, @tutorial_committee
      assert_equal tutorial_committees(tutorial_committee.to_sym).id, @tutorial_committee.id
      assert_equal tutorial_committees(tutorial_committee.to_sym).user_id, @tutorial_committee.user_id
      assert_equal tutorial_committees(tutorial_committee.to_sym).studentname, @tutorial_committee.studentname
      assert_equal tutorial_committees(tutorial_committee.to_sym).degree_id, @tutorial_committee.degree_id
      assert_equal tutorial_committees(tutorial_committee.to_sym).year, @tutorial_committee.year
      assert_equal tutorial_committees(tutorial_committee.to_sym).institutioncareer_id, @tutorial_committee.institutioncareer_id
    }
  end

  def test_updating_user_id
    @tutorial_committees.each { |tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_equal tutorial_committees(tutorial_committee.to_sym).user_id, @tutorial_committee.user_id
      @tutorial_committee.user_id = 2
      assert @tutorial_committee.update
      assert_not_equal tutorial_committees(tutorial_committee.to_sym).user_id, @tutorial_committee.user_id
    }
  end

  def test_updating_degree_id
    @tutorial_committees.each { |tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_equal tutorial_committees(tutorial_committee.to_sym).degree_id, @tutorial_committee.degree_id
      @tutorial_committee.degree_id = 4
      assert @tutorial_committee.update
      assert_not_equal tutorial_committees(tutorial_committee.to_sym).degree_id, @tutorial_committee.degree_id
    }
  end
  def test_updating_year
    @tutorial_committees.each { |tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_equal tutorial_committees(tutorial_committee.to_sym).year, @tutorial_committee.year
      @tutorial_committee.year = @tutorial_committee.year - 2
      assert @tutorial_committee.update
      assert_not_equal tutorial_committees(tutorial_committee.to_sym).year, @tutorial_committee.year
    }
  end

  def test_updating_studentname
    @tutorial_committees.each { |tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_equal tutorial_committees(tutorial_committee.to_sym).studentname, @tutorial_committee.studentname
      @tutorial_committee.studentname = 'Joaquin Simone'
      assert @tutorial_committee.update
      assert_not_equal tutorial_committees(tutorial_committee.to_sym).studentname, @tutorial_committee.studentname
    }
  end

  def test_updating_institutioncareer_id
    @tutorial_committees.each { |tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_equal tutorial_committees(tutorial_committee.to_sym).institutioncareer_id, @tutorial_committee.institutioncareer_id
      @tutorial_committee.institutioncareer_id == 1 ? @tutorial_committee.institutioncareer_id = @tutorial_committee.institutioncareer_id  + 1 : @tutorial_committee.institutioncareer_id = @tutorial_committee.institutioncareer_id - 1
      assert @tutorial_committee.update
      assert_not_equal tutorial_committees(tutorial_committee.to_sym).institutioncareer_id, @tutorial_committee.institutioncareer_id
    }
  end

  def test_deleting_tutorial_committees
    @tutorial_committees.each { |tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      @tutorial_committee.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @tutorial_committee = TutorialCommittee.new
    assert !@tutorial_committee.save
  end

  # Boundary
  def test_bad_values_for_id
    @mytutorial_committee.id = 1.6
    assert !@mytutorial_committee.valid?
    @mytutorial_committee.id = 'mi_id'
    assert !@mytutorial_committee.valid?
  end

  def test_bad_values_for_user_id
    @mytutorial_committee.user_id= 1.6
    assert !@mytutorial_committee.valid?
    @mytutorial_committee.user_id = 'mi_id_texto'
    assert !@mytutorial_committee.valid?
  end

  def test_bad_values_for_degree_id
    @mytutorial_committee.degree_id = nil
    assert !@mytutorial_committee.valid?
    @mytutorial_committee.degree_id = 1.6
    assert !@mytutorial_committee.valid?
    @mytutorial_committee.degree_id = 'mi_id_texto'
    assert !@mytutorial_committee.valid?
  end

  def test_bad_values_for_year
    @mytutorial_committee.year = nil
    assert !@mytutorial_committee.valid?
    @mytutorial_committee.year = 1.6
    assert !@mytutorial_committee.valid?
    @mytutorial_committee.year = 'my_year'
    assert !@mytutorial_committee.valid?
  end

  def test_bad_values_for_institutioncareer_id
    @mytutorial_committee.institutioncareer_id = nil
    assert !@mytutorial_committee.valid?
    @mytutorial_committee.institutioncareer_id = 1.6
    assert !@mytutorial_committee.valid?
    @mytutorial_committee.institutioncareer_id = 'mi_id_texto'
    assert !@mytutorial_committee.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @tutorial_committees.each { | tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_kind_of TutorialCommittee, @tutorial_committee
      assert_equal @tutorial_committee.user_id, User.find(@tutorial_committee.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @tutorial_committees.each { | tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_kind_of TutorialCommittee, @tutorial_committee
      @tutorial_committee.user_id = 5
      begin
        return true if @tutorial_committee.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for institutioncareer
  def test_cross_checking_for_institutioncareer_id
    @tutorial_committees.each { | tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_kind_of TutorialCommittee, @tutorial_committee
      assert_equal @tutorial_committee.institutioncareer_id, Institutioncareer.find(@tutorial_committee.institutioncareer_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institutioncareer_id
    @tutorial_committees.each { | tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_kind_of TutorialCommittee, @tutorial_committee
      @tutorial_committee.institutioncareer_id = 100000
      assert @tutorial_committee.valid?
      begin
        return true if @tutorial_committee.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for degree
  def test_cross_checking_for_degree_id
    @tutorial_committees.each { | tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_kind_of TutorialCommittee, @tutorial_committee
      assert_equal @tutorial_committee.degree_id, Degree.find(@tutorial_committee.degree_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_degree_id
    @tutorial_committees.each { | tutorial_committee|
      @tutorial_committee = TutorialCommittee.find(tutorial_committees(tutorial_committee.to_sym).id)
      assert_kind_of TutorialCommittee, @tutorial_committee
      @tutorial_committee.degree_id = 100000
      assert @tutorial_committee.valid?
      begin
        return true if @tutorial_committee.update
      rescue StandardError => x
        return false
      end
    }
  end
end
