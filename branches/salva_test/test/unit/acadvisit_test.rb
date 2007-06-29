require File.dirname(__FILE__) + '/../test_helper'
require 'acadvisit'

class AcadvisitTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles,:institutiontypes,:institutions,:userstatuses,:users,:acadvisittypes, :acadvisits

  def setup
    @acadvisits = %w(chavez pipo)
    @myacadvisit = Acadvisit.new({:name => 'Cuahtemoc Blanco', :acadvisittype_id => 2, :user_id =>2, :country_id => 484, :startyear => 2007, :institution_id => 1})
  end

  # Right - CRUD
  def test_creating_acadvisits_from_yaml
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      assert_equal acadvisits(acadvisit.to_sym).id, @acadvisit.id
      assert_equal acadvisits(acadvisit.to_sym).name, @acadvisit.name
      assert_equal acadvisits(acadvisit.to_sym).acadvisittype_id, @acadvisit.acadvisittype_id
      assert_equal acadvisits(acadvisit.to_sym).user_id, @acadvisit.user_id
      assert_equal acadvisits(acadvisit.to_sym).country_id, @acadvisit.country_id
      assert_equal acadvisits(acadvisit.to_sym).institution_id, @acadvisit.institution_id
    }
  end

  def test_updating_acadvisits_name
    @acadvisits.each { |acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_equal acadvisits(acadvisit.to_sym).name, @acadvisit.name
      @acadvisit.name = @acadvisit.name.chars.reverse
      assert @acadvisit.update
      assert_not_equal acadvisits(acadvisit.to_sym).name, @acadvisit.name
    }
  end

  def test_deleting_acadvisits
    @acadvisits.each { |acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      @acadvisit.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @acadvisit = Acadvisit.new
    assert !@acadvisit.save
  end

  def test_creating_duplicated_acadvisit
    @myacadvisit = Acadvisit.new({:name => 'Felipe Calderon', :acadvisittype_id => 2, :user_id  =>3, :country_id => 484, :startyear => 2007, :institution_id => 1})
    @myacadvisit.id = 2
    assert !@myacadvisit.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myacadvisit.id = 1.6
    assert !@myacadvisit.valid?

    # Negative numbers
    # @myacadvisit.id = -1
    #assert !@myacadvisit.valid?
  end

  def test_bad_values_for_name
    @myacadvisit.name = nil
    assert !@myacadvisit.valid?
  end

  def test_bad_values_for_country_id
    # Checking constraints for name
    # Nil name
    @myacadvisit.country_id = nil
    assert !@myacadvisit.valid?

    # Float number for ID
    @myacadvisit.country_id = 3.1416
    assert !@myacadvisit.valid?

    # Negative numbers
    # @myacadvisit.country_id = -1
    #assert !@myacadvisit.valid?
  end


  def test_bad_values_for_institutions_id
    # Checking constraints for name
    # Nil name
    @myacadvisit.institution_id = nil
    assert !@myacadvisit.valid?

    # Float number for ID
    @myacadvisit.institution_id = 3.1416
    assert !@myacadvisit.valid?

    # Negative numbers
    #@myacadvisit.institution_id = -1
    #assert !@myacadvisit.valid?
  end


  def test_bad_values_for_acadvisittype_id
    # Checking constraints for name
    # Nil name
    @myacadvisit.acadvisittype_id = nil
    assert !@myacadvisit.valid?

    # Float number for ID
    @myacadvisit.acadvisittype_id = 3.1416
    assert !@myacadvisit.valid?

    # Negative numbers
    #@myacadvisit.acadvisittype_id = -1
    #assert !@myacadvisit.valid?
  end

  def test_bad_values_for_user_id
    # Checking constraints for name
    # Nil name
    @myacadvisit.user_id = nil
    assert !@myacadvisit.valid?

    # Float number for ID
    @myacadvisit.user_id = 3.1416
    assert !@myacadvisit.valid?

    # Negative numbers
    #@myacadvisit.user_id = -1
    #assert !@myacadvisit.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_acadvisittype_id
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      assert_equal @acadvisit.acadvisittype_id, Acadvisittype.find(@acadvisit.acadvisittype_id).id
    }
  end

  def test_cross_checking_with_bad_values_for_acadvisittype_id
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      @acadvisit.acadvisittype_id = 108
      begin
        return true if @acadvisit.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_country_id
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      assert_equal @acadvisit.country_id, Country.find(@acadvisit.country_id).id
    }
  end

  def test_cross_checking_with_bad_values_for_country_id
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      @acadvisit.country_id = 108
      begin
        return true if @acadvisit.update
      rescue StandardError => x
        return false
      end
    }
  end


  def test_cross_checking_for_Institution_id
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      assert_equal @acadvisit.institution_id, Institution.find(@acadvisit.institution_id).id
    }
  end

  def test_cross_checking_with_bad_values_for_Institution_id
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      @acadvisit.institution_id = 108
      begin
        return true if @acadvisit.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_User_id
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      assert_equal @acadvisit.user_id, User.find(@acadvisit.user_id).id
    }
  end

  def test_cross_checking_with_bad_values_for_User_id
    @acadvisits.each { | acadvisit|
      @acadvisit = Acadvisit.find(acadvisits(acadvisit.to_sym).id)
      assert_kind_of Acadvisit, @acadvisit
      @acadvisit.user_id = 108
      begin
        return true if @acadvisit.update
      rescue StandardError => x
        return false
      end
    }
  end

end

