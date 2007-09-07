require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'techproductstatus'
require 'techproducttype'
require 'techproduct'

class TechproductTest < Test::Unit::TestCase
  fixtures :degrees, :careers, :userstatuses, :techproducttypes, :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :institutioncareers, :users, :techproductstatuses, :techproducts

  def setup
    @techproducts = %w(van_gogh_had_turbulence_down_to_a_fine_art van_gogh_painted_perfect_turbulence)
    @mytechproduct = Techproduct.new({:title => 'Contact Centers', :techproducttype_id => 3, :authors => 'John Lecon, Peter Smith', :techproductstatus_id => 3})
  end

  # Right - CRUD
  def test_creating_techproduct_from_yaml
    @techproducts.each { | techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_kind_of Techproduct, @techproduct
      assert_equal techproducts(techproduct.to_sym).id, @techproduct.id
      assert_equal techproducts(techproduct.to_sym).title, @techproduct.title
      assert_equal techproducts(techproduct.to_sym).techproducttype_id, @techproduct.techproducttype_id
      assert_equal techproducts(techproduct.to_sym).authors, @techproduct.authors
      assert_equal techproducts(techproduct.to_sym).techproductstatus_id, @techproduct.techproductstatus_id
    }
  end

  def test_updating_title
    @techproducts.each { |techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_equal techproducts(techproduct.to_sym).title, @techproduct.title
      @techproduct.title = 'Presencia de las TI en las empresas'
      assert @techproduct.update
      assert_not_equal techproducts(techproduct.to_sym).title, @techproduct.title
    }
  end

  def test_updating_techproducttype_id
    @techproducts.each { |techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_equal techproducts(techproduct.to_sym).techproducttype_id, @techproduct.techproducttype_id
      @techproduct.techproducttype_id = 4
      assert @techproduct.update
      assert_not_equal techproducts(techproduct.to_sym).techproducttype_id, @techproduct.techproducttype_id
    }
  end

  def test_updating_authors
    @techproducts.each { |techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_equal techproducts(techproduct.to_sym).authors, @techproduct.authors
      @techproduct.authors = 'Jose Luis Linares'
      assert @techproduct.update
      assert_not_equal techproducts(techproduct.to_sym).authors, @techproduct.authors
    }
  end

  def test_updating_techproductstatus_id
    @techproducts.each { |techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_equal techproducts(techproduct.to_sym).techproductstatus_id, @techproduct.techproductstatus_id
      @techproduct.techproductstatus_id = 3
      assert @techproduct.update
      assert_not_equal techproducts(techproduct.to_sym).techproductstatus_id, @techproduct.techproductstatus_id
    }
  end

  def test_deleting_techproducts
    @techproducts.each { |techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      @techproduct.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Techproduct.find(techproducts(techproduct.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @techproduct = Techproduct.new
    assert !@techproduct.save
  end

  # Boundary
  def test_bad_values_for_id
    @mytechproduct.id = 1.6
    assert !@mytechproduct.valid?
    @mytechproduct.id = 'mi_id'
    assert !@mytechproduct.valid?
  end

  def test_bad_values_for_authors
    @mytechproduct.authors = nil
    assert !@mytechproduct.valid?
  end

  def test_bad_values_for_title
    @mytechproduct.title = nil
    assert !@mytechproduct.valid?
  end

  def test_bad_values_for_techproducttype_id
    @mytechproduct.techproducttype_id = 1.6
    assert !@mytechproduct.valid?
    @mytechproduct.techproducttype_id = 'mi_id_texto'
    assert !@mytechproduct.valid?
  end

  def test_bad_values_for_intitution_id
    @mytechproduct.institution_id = 1.6
    assert !@mytechproduct.valid?
    @mytechproduct.institution_id = 'mi_id_texto'
    assert !@mytechproduct.valid?
  end

  def test_bad_values_for_techproductstatus_id
    @mytechproduct.techproductstatus_id = 1.6
    assert !@mytechproduct.valid?
    @mytechproduct.techproductstatus_id = 'mi_id_texto'
    assert !@mytechproduct.valid?
  end

  #cross-Checking test for techproducttype_id
  def test_cross_checking_for_techproducttype_id
    @techproducts.each { | techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_kind_of Techproduct, @techproduct
      assert_equal @techproduct.techproducttype_id, Techproducttype.find(@techproduct.techproducttype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_techproducttype_id_id
    @techproducts.each { | techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_kind_of Techproduct, @techproduct
      @techproduct.techproducttype_id = 500
      begin
        return true if @techproduct.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for techproductsatuts_id
  def test_cross_checking_for_techproductstatus_id
    @techproducts.each { | techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_kind_of Techproduct, @techproduct
      assert_equal @techproduct.techproductstatus_id, Techproductstatus.find(@techproduct.techproductstatus_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_techproductstatus_id_id
    @techproducts.each { | techproduct|
      @techproduct = Techproduct.find(techproducts(techproduct.to_sym).id)
      assert_kind_of Techproduct, @techproduct
      @techproduct.techproductstatus_id = 500
      begin
        return true if @techproduct.update
      rescue StandardError => x
        return false
      end
    }
  end
end
