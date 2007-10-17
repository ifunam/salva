require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'user'
require 'jobposition'

class JobpositionTest < Test::Unit::TestCase
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :userstatuses, :users, :jobpositions

  def setup
    @jobpositions = %w(tecnico_academico investigador secretario_academico)
    @myjobposition = Jobposition.new({:institution_id => 57, :user_id => 2, :startyear => 2007})
  end

  # Right - CRUD
  def test_creating_jobpositions_from_yaml
    @jobpositions.each { | jobposition|
      @jobposition = Jobposition.find(jobpositions(jobposition.to_sym).id)
      assert_kind_of Jobposition, @jobposition
      assert_equal jobpositions(jobposition.to_sym).id, @jobposition.id
      assert_equal jobpositions(jobposition.to_sym).user_id, @jobposition.user_id
      assert_equal jobpositions(jobposition.to_sym).institution_id, @jobposition.institution_id
      assert_equal jobpositions(jobposition.to_sym).startyear, @jobposition.startyear
    }
  end

  def test_deleting_jobpositions
    @jobpositions.each { |jobposition|
      @jobposition = Jobposition.find(jobpositions(jobposition.to_sym).id)
      @jobposition.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Jobposition.find(jobpositions(jobposition.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @jobposition = Jobposition.new
    assert !@jobposition.save
  end

  def test_creating_duplicated_jobposition
    @jobposition = Jobposition.new({:institution_id => 57, :user_id => 3, :startyear => 2003})
    assert !@jobposition.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myjobposition.id = 1.6
    assert !@myjobposition.valid?

    @myjobposition.id = 'mi_id'
    assert !@myjobposition.valid?

    #@myjobposition.id = -1.0
    #assert !@myjobposition.valid?
  end

  def test_bad_values_for_user_id
    @myjobposition.user_id = nil
    assert !@myjobposition.valid?

    @myjobposition.user_id= 1.6
    assert !@myjobposition.valid?

    @myjobposition.user_id = 'mi_id'
    assert !@myjobposition.valid?

    #@myjobposition.user_id = -1.0
    #assert !@myjobposition.valid?
  end

  def test_bad_values_for_institution_id
    @myjobposition.institution_id = nil
    assert !@myjobposition.valid?

    @myjobposition.institution_id = 3.1416
    assert !@myjobposition.valid?

    @myjobposition.institution_id = 'mi_id'
    assert !@myjobposition.valid?

    #@myjobposition.institution_id = -1.0
    #assert !@myjobposition.valid?
  end

  def test_bad_values_for_jobpositioncategory_id
    @myjobposition.jobpositioncategory_id  = 3.1416
    assert !@myjobposition.valid?

    @myjobposition.jobpositioncategory_id  = 'mi_id'
    assert !@myjobposition.valid?

    #@myjobposition.jobpositioncategory_id  = -1.0
    #assert !@myjobposition.valid?
  end

  def test_bad_values_for_contracttype_id
    @myjobposition.contracttype_id  = 3.1416
    assert !@myjobposition.valid?

    @myjobposition.contracttype_id  = 'mi_id'
    assert !@myjobposition.valid?

    #@myjobposition.contracttype_id  = -1.0
    #assert !@myjobposition.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_institution_id
    @jobpositions.each { | jobposition|
      @jobposition = Jobposition.find(jobpositions(jobposition.to_sym).id)
      assert_kind_of Jobposition, @jobposition
      assert_equal @jobposition.institution_id, Institution.find(@jobposition.institution_id).id
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
    @jobpositions.each { | jobposition|
      @jobposition = Jobposition.find(jobpositions(jobposition.to_sym).id)
      assert_kind_of Jobposition, @jobposition
      @jobposition.institution_id = 1000000
      begin
        return true if @jobposition.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_user_id
    @jobpositions.each { | jobposition|
      @jobposition = Jobposition.find(jobpositions(jobposition.to_sym).id)

      assert_kind_of Jobposition, @jobposition
      assert_equal @jobposition.user_id, User.find(@jobposition.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @jobpositions.each { | jobposition|
      @jobposition = Jobposition.find(jobpositions(jobposition.to_sym).id)
      assert_kind_of Jobposition, @jobposition
      @jobposition.user_id = 100000
      begin
        return true if @jobposition.save
      rescue StandardError => x
        return false
      end
    }
  end

end
