require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'grant'

class GrantTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :grants
  def setup
    @grants = %w(beca_unam beca_sep)
    @mygrant = Grant.new({:name => 'Beca Genero', :institution_id => 3})
  end

  # Right - CRUD
  def test_creating_grants_from_yaml
    @grants.each { | grant|
      @grant = Grant.find(grants(grant.to_sym).id)
      assert_kind_of Grant, @grant
      assert_equal grants(grant.to_sym).id, @grant.id
      assert_equal grants(grant.to_sym).name, @grant.name
      assert_equal grants(grant.to_sym).institution_id, @grant.institution_id
    }
  end

  def test_updating_grants_name
    @grants.each { |grant|
      @grant = Grant.find(grants(grant.to_sym).id)
      assert_equal grants(grant.to_sym).name, @grant.name
      @grant.name = @grant.name.chars.reverse
      assert @grant.update
      assert_not_equal grants(grant.to_sym).name, @grant.name
    }
  end

  def test_deleting_grants
    @grants.each { |grant|
      @grant = Grant.find(grants(grant.to_sym).id)
      @grant.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Grant.find(grants(grant.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @grant = Grant.new
    assert !@grant.save
  end

  def test_creating_duplicated_grant
    @grant = Grant.new({:name => 'Beca SEP', :institution_id => 5588})
    assert !@grant.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mygrant.id = 1.6
    assert !@mygrant.valid?
    @mygrant.id = 'mi_id'
    assert !@mygrant.valid?
  end

  def test_bad_values_for_name
    # Float number for ID
    @mygrant.name = nil
    assert !@mygrant.valid?
    @mygrant.name = 'nombre de mi grant' * 80
    assert !@mygrant.valid?
    @mygrant.name = 'a'
    assert !@mygrant.valid?
  end

  def test_bad_values_for_institution_id
    @mygrant.institution_id = nil
    assert !@mygrant.valid?
    @mygrant.institution_id= 1.6
    assert !@mygrant.valid?
    @mygrant.institution_id = 'mi_id_texto'
    assert !@mygrant.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_institution_id
    @grants.each { | grant|
      @grant = Grant.find(grants(grant.to_sym).id)
      assert_kind_of Grant, @grant
      assert_equal @grant.institution_id, Institution.find(@grant.institution_id).id
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
    @grants.each { | grant|
      @grant = Grant.find(grants(grant.to_sym).id)
      assert_kind_of Grant, @grant
      @grant.institution_id = 999999999
      begin
        return true if @grant.update
      rescue StandardError => x
        return false
      end
    }
  end
end
