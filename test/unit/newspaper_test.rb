require File.dirname(__FILE__) + '/../test_helper'
require 'newspaper'
require 'country'

class NewspaperTest < Test::Unit::TestCase
  fixtures :countries, :newspapers

  def setup
    @newspapers = %w(el_sur_de_campeche el_hidrocalido)
    @mynewspaper = Newspaper.new({:name => 'Encuentro', :country_id => 3})
  end

  # Right - CRUD
  def test_creating_newspapers_from_yaml
    @newspapers.each { | newspaper|
      @newspaper = Newspaper.find(newspapers(newspaper.to_sym).id)
      assert_kind_of Newspaper, @newspaper
      assert_equal newspapers(newspaper.to_sym).id, @newspaper.id
      assert_equal newspapers(newspaper.to_sym).name, @newspaper.name
      assert_equal newspapers(newspaper.to_sym).country_id, @newspaper.country_id
    }
  end

  def test_updating_newspapers_name
    @newspapers.each { |newspaper|
      @newspaper = Newspaper.find(newspapers(newspaper.to_sym).id)
      assert_equal newspapers(newspaper.to_sym).name, @newspaper.name
      @newspaper.name = @newspaper.name.chars.reverse
      assert @newspaper.save
      assert_not_equal newspapers(newspaper.to_sym).name, @newspaper.name
    }
  end

  def test_deleting_newspapers
    @newspapers.each { |newspaper|
      @newspaper = Newspaper.find(newspapers(newspaper.to_sym).id)
      @newspaper.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Newspaper.find(newspapers(newspaper.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @newspaper = Newspaper.new
    assert !@newspaper.save
  end

  def test_creating_duplicated_newspaper
    @newspaper = Newspaper.new({:name => 'El Sur de Campeche', :country_id => 484})
    assert !@newspaper.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mynewspaper.id = 1.6
    assert !@mynewspaper.valid?

    # Negative numbers
    #@mynewspaper.id = -1
    #assert !@mynewspaper.valid?
  end

  def test_bad_values_for_name
    @mynewspaper.name = nil
    assert !@mynewspaper.valid?
  end

  def test_bad_values_for_country_id
    # Checking constraints for name
    # Nil name
    @mynewspaper.country_id = nil
    assert !@mynewspaper.valid?

    # Float number for ID
    @mynewspaper.country_id = 3.1416
    assert !@mynewspaper.valid?

    # Negative numbers
    #@mynewspaper.country_id = -1
    #assert !@mynewspaper.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_country_id
    @newspapers.each { | newspaper|
      @newspaper = Newspaper.find(newspapers(newspaper.to_sym).id)
      assert_kind_of Newspaper, @newspaper
      assert_equal @newspaper.country_id, Country.find(@newspaper.country_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_country_id
    @newspapers.each { | newspaper|
      @newspaper = Newspaper.find(newspapers(newspaper.to_sym).id)
      assert_kind_of Newspaper, @newspaper
      @newspaper.country_id = 2000
      begin
        return true if @newspaper.save
      rescue StandardError => x
        return false
      end
    }
  end
end

