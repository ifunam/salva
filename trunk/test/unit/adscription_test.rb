require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'adscription'

class AdscriptionTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions,  :adscriptions

  def setup
    @adscriptions = %w(aerosoles_atmosfericos citogenetica_ambiental contaminacion_ambiental)
    @myadscription = Adscription.new({:name => 'Bioclimatología ', :institution_id => 57})
  end

  # Right - CRUD
  def test_creating_adscriptions_from_yaml
    @adscriptions.each { | adscription|
      @adscription = Adscription.find(adscriptions(adscription.to_sym).id)
      assert_kind_of Adscription, @adscription
      assert_equal adscriptions(adscription.to_sym).id, @adscription.id
      assert_equal adscriptions(adscription.to_sym).name, @adscription.name
      assert_equal adscriptions(adscription.to_sym).institution_id, @adscription.institution_id
    }
  end

  def test_updating_adscriptions_name
    @adscriptions.each { |adscription|
      @adscription = Adscription.find(adscriptions(adscription.to_sym).id)
      assert_equal adscriptions(adscription.to_sym).name, @adscription.name
      @adscription.name = @adscription.name.chars.reverse
      assert @adscription.update
      assert_not_equal adscriptions(adscription.to_sym).name, @adscription.name
    }
  end

  def test_deleting_adscriptions
    @adscriptions.each { |adscription|
      @adscription = Adscription.find(adscriptions(adscription.to_sym).id)
      @adscription.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Adscription.find(adscriptions(adscription.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @adscription = Adscription.new
    assert !@adscription.save
  end

  def test_creating_duplicated_adscription
    @adscription = Adscription.new({:name => 'Citogenética ambiental', :institution_id => 57})
    assert !@adscription.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myadscription.id = 1.6
    assert !@myadscription.valid?
    @myadscription.id = 'mi_id'
    assert !@myadscription.valid?
  end

  def test_bad_values_for_name
    # Float number for ID
    @myadscription.name = nil
    assert !@myadscription.valid?
  end

  def test_bad_values_for_institution_id
    @myadscription.institution_id = nil
    assert !@myadscription.valid?
    @myadscription.institution_id= 1.6
    assert !@myadscription.valid?
    @myadscription.institution_id = 'mi_id'
    assert !@myadscription.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_institution_id
    @adscriptions.each { | adscription|
      @adscription = Adscription.find(adscriptions(adscription.to_sym).id)
      assert_kind_of Adscription, @adscription
      assert_equal @adscription.institution_id, Institution.find(@adscription.institution_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institution_id
    @adscriptions.each { | adscription|
      @adscription = Adscription.find(adscriptions(adscription.to_sym).id)
      assert_kind_of Adscription, @adscription
      @adscription.institution_id = 999999999
      begin
        return true if @adscription.update
      rescue StandardError => x
        return false
      end
    }
  end
end
