require File.dirname(__FILE__) + '/../test_helper'
require 'stimulustype'

class StimulustypeTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :stimulustypes

  def setup
    @stimulustypes = %w(pride paipa sni)
    @mystimulustype = Stimulustype.new({:name => 'fobaproa', :institution_id => 3})
  end

  # Right - CRUD
  def test_creating_stimulustypes_from_yaml
    @stimulustypes.each { | stimulustype|
      @stimulustype = Stimulustype.find(stimulustypes(stimulustype.to_sym).id)
      assert_kind_of Stimulustype, @stimulustype
      assert_equal stimulustypes(stimulustype.to_sym).id, @stimulustype.id
      assert_equal stimulustypes(stimulustype.to_sym).name, @stimulustype.name
      assert_equal stimulustypes(stimulustype.to_sym).institution_id, @stimulustype.institution_id
    }
  end

  def test_updating_stimulustypes_name
    @stimulustypes.each { |stimulustype|
      @stimulustype = Stimulustype.find(stimulustypes(stimulustype.to_sym).id)
      assert_equal stimulustypes(stimulustype.to_sym).name, @stimulustype.name
      @stimulustype.name = @stimulustype.name.chars.reverse
      assert @stimulustype.save
      assert_not_equal stimulustypes(stimulustype.to_sym).name, @stimulustype.name
    }
  end

  def test_deleting_stimulustypes
    @stimulustypes.each { |stimulustype|
      @stimulustype = Stimulustype.find(stimulustypes(stimulustype.to_sym).id)
      @stimulustype.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Stimulustype.find(stimulustypes(stimulustype.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @stimulustype = Stimulustype.new
    assert !@stimulustype.save
  end

  def test_creating_duplicated_stimulustype
    @stimulustype = Stimulustype.new({:name => 'PRIDE', :institution_id => 1 })
    @stimulustype.id = 1
    assert !@stimulustype.save
  end

  # Boundary
  def test_bad_values_for_id
    @mystimulustype.id = 'xx'
    assert !@mystimulustype.valid?

    # Float number for ID
    @mystimulustype.id = 1.6
    assert !@mystimulustype.valid?
    #@mystimulustype.id = -1
    #assert !@mystimulustype.valid?
  end

  def test_bad_values_for_name
    @mystimulustype.name = nil
    assert !@mystimulustype.valid?
  end

  def test_bad_values_for_institution_id
    # Checking constraints for name

    @mystimulustype.institution_id = 'xx'
    assert !@mystimulustype.valid?

    @mystimulustype.institution_id = nil
    assert !@mystimulustype.valid?

    @mystimulustype.institution_id = 3.1416
    assert !@mystimulustype.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_institution_id
    @stimulustypes.each { | stimulustype|
      @stimulustype = Stimulustype.find(stimulustypes(stimulustype.to_sym).id)
      assert_kind_of Stimulustype, @stimulustype
      assert_equal @stimulustype.institution_id, Institution.find(@stimulustype.institution_id).id
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
    @stimulustypes.each { | stimulustype|
      @stimulustype = Stimulustype.find(stimulustypes(stimulustype.to_sym).id)
      assert_kind_of Stimulustype, @stimulustype
      @stimulustype.institution_id =78581
      begin
        return true if @stimulustype.save
      rescue StandardError => x
        return false
      end
    }
  end
end
