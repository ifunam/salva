require File.dirname(__FILE__) + '/../test_helper'
require 'country'

class CountryTest < Test::Unit::TestCase
  fixtures :countries

  def setup
    @countries = %w(mexico japan ukrania)
    @mycountry = Country.new({:id => 156, :name => 'China', :code => 'CN'})
  end

  # Right - CRUD
  def test_creating_countries_from_yaml
    @countries.each { | country|
      @country = Country.find(countries(country.to_sym).id)
      assert_kind_of Country, @country
      assert_equal countries(country.to_sym).id, @country.id
      assert_equal countries(country.to_sym).name, @country.name
    }
  end

  def test_updating_countries_name
    @countries.each { |country|
      @country = Country.find(countries(country.to_sym).id)
      assert_equal countries(country.to_sym).name, @country.name
      @country.name = @country.name.chars.reverse
      assert @country.update
      assert_not_equal countries(country.to_sym).name, @country.name
    }
  end

  def test_deleting_countries
    @countries.each { |country|
      @country = Country.find(countries(country.to_sym).id)
      @country.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Country.find(countries(country.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @country = Country.new
    assert !@country.save
  end

  def test_uniqueness
    @country = Country.new({:name => 'México', :citizen => 'Mexicana',
                             :code =>'MX'})
    @country.id = 484
    assert !@country.save
  end

  # Boundary
  def test_bad_values_for_id
    @mycountry.id = nil
    assert !@mycountry.valid?

    #@mycountry.id = -2
    #assert !@mycountry.valid?

    @mycountry.id = 5.6
    assert !@mycountry.valid?
  end

  def test_bad_values_for_name
    @mycountry.name = nil
    assert !@mycountry.valid?

    @mycountry.name = "China2"
    assert !@mycountry.valid?
  end

  def test_bad_values_for_code
    @mycountry.code = nil
    assert !@mycountry.valid?

    @mycountry.code = "C"
    assert !@mycountry.valid?

    @mycountry.code = "AAAA"
    assert !@mycountry.valid?

    @mycountry.code = "A2"
    assert !@mycountry.valid?
  end
end

