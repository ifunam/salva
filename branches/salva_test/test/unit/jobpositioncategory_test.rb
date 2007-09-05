require File.dirname(__FILE__) + '/../test_helper'

require 'roleinjobposition'
require 'jobpositiontype'
require 'jobpositioncategory'

class JobpositioncategoryTest < Test::Unit::TestCase
  fixtures  :jobpositionlevels, :roleinjobpositions, :jobpositiontypes, :jobpositioncategories

  def setup
    @jobpositioncategories = %w(tecnico_academico_tc investigador_tc secretario_academico)
    @myjobpositioncategory = Jobpositioncategory.new({ :jobpositiontype_id => 3, :roleinjobposition_id => 1})
  end

  # Right - CRUD
  def test_creating_jobpositioncategories_from_yaml
    @jobpositioncategories.each { | jobpositioncategory|
      @jobpositioncategory = Jobpositioncategory.find(jobpositioncategories(jobpositioncategory.to_sym).id)
      assert_kind_of Jobpositioncategory, @jobpositioncategory
      assert_equal jobpositioncategories(jobpositioncategory.to_sym).id, @jobpositioncategory.id
      assert_equal jobpositioncategories(jobpositioncategory.to_sym).jobpositiontype_id, @jobpositioncategory.jobpositiontype_id
      assert_equal jobpositioncategories(jobpositioncategory.to_sym).roleinjobposition_id, @jobpositioncategory.roleinjobposition_id
    }
  end

  def test_deleting_jobpositioncategories
    @jobpositioncategories.each { |jobpositioncategory|
      @jobpositioncategory = Jobpositioncategory.find(jobpositioncategories(jobpositioncategory.to_sym).id)
      @jobpositioncategory.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Jobpositioncategory.find(jobpositioncategories(jobpositioncategory.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @jobpositioncategory = Jobpositioncategory.new
    assert !@jobpositioncategory.save
  end

  def test_creating_duplicated_jobpositioncategory
    @jobpositioncategory = Jobpositioncategory.new({:jobpositiontype_id => 1, :roleinjobposition_id => 2})
    assert !@jobpositioncategory.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myjobpositioncategory.id = 1.6
    assert !@myjobpositioncategory.valid?
    @myjobpositioncategory.id = 'mi_id'
    assert !@myjobpositioncategory.valid?
  end

  def test_bad_values_for_jobpositiontype_id
    @myjobpositioncategory.jobpositiontype_id = nil
    assert !@myjobpositioncategory.valid?

    @myjobpositioncategory.jobpositiontype_id= 1.6
    assert !@myjobpositioncategory.valid?

    @myjobpositioncategory.jobpositiontype_id = 'mi_id'
    assert !@myjobpositioncategory.valid?
  end

  def test_bad_values_for_roleinjobposition_id
    @myjobpositioncategory.roleinjobposition_id = nil
    assert !@myjobpositioncategory.valid?

    @myjobpositioncategory.roleinjobposition_id = 3.1416
    assert !@myjobpositioncategory.valid?
    @myjobpositioncategory.roleinjobposition_id = 'mi_id'
    assert !@myjobpositioncategory.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_roleinjobposition_id
    @jobpositioncategories.each { | jobpositioncategory|
      @jobpositioncategory = Jobpositioncategory.find(jobpositioncategories(jobpositioncategory.to_sym).id)
      assert_kind_of Jobpositioncategory, @jobpositioncategory
      assert_equal @jobpositioncategory.roleinjobposition_id, Roleinjobposition.find(@jobpositioncategory.roleinjobposition_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleinjobposition_id
    @jobpositioncategories.each { | jobpositioncategory|
      @jobpositioncategory = Jobpositioncategory.find(jobpositioncategories(jobpositioncategory.to_sym).id)
      assert_kind_of Jobpositioncategory, @jobpositioncategory
      @jobpositioncategory.roleinjobposition_id = 1000000
      begin
        return true if @jobpositioncategory.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_jobpositiontype_id
    @jobpositioncategories.each { | jobpositioncategory|
      @jobpositioncategory = Jobpositioncategory.find(jobpositioncategories(jobpositioncategory.to_sym).id)

      assert_kind_of Jobpositioncategory, @jobpositioncategory
      assert_equal @jobpositioncategory.jobpositiontype_id, Jobpositiontype.find(@jobpositioncategory.jobpositiontype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_jobpositiontype_id
    @jobpositioncategories.each { | jobpositioncategory|
      @jobpositioncategory = Jobpositioncategory.find(jobpositioncategories(jobpositioncategory.to_sym).id)
      assert_kind_of Jobpositioncategory, @jobpositioncategory
      @jobpositioncategory.jobpositiontype_id = 100000
      begin
        return true if @jobpositioncategory.update
      rescue StandardError => x
        return false
      end
    }
  end

end
