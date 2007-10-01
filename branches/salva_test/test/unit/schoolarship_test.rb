require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'schoolarship'

class SchoolarshipTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles,:institutiontypes, :institutions, :schoolarships

  def setup
    @schoolarships = %w(direccion_general_de_asuntos_del_personal_academico  direccion_general_de_estudios_de_posgrado beca_sep)
    @myschoolarship = Schoolarship.new({:name => 'ESIME', :institution_id => 1})
  end

  # Right - CRUD
  def test_creating_from_yaml
    @schoolarships.each { | schoolarship|
      @schoolarship = Schoolarship.find(schoolarships(schoolarship.to_sym).id)
      assert_kind_of Schoolarship, @schoolarship
      assert_equal schoolarships(schoolarship.to_sym).id, @schoolarship.id
      assert_equal schoolarships(schoolarship.to_sym).name, @schoolarship.name
      assert_equal schoolarships(schoolarship.to_sym).institution_id, @schoolarship.institution_id
    }
  end

  def test_updating_schoolarships_name
    @schoolarships.each { |schoolarship|
      @schoolarship = Schoolarship.find(schoolarships(schoolarship.to_sym).id)
      assert_equal schoolarships(schoolarship.to_sym).name, @schoolarship.name
      @schoolarship.name = @schoolarship.name.chars.reverse
      assert @schoolarship.save
      assert_not_equal schoolarships(schoolarship.to_sym).name, @schoolarship.name
    }
  end

  def test_deleting_schoolarships
    @schoolarships.each { |schoolarship|
      @schoolarship = Schoolarship.find(schoolarships(schoolarship.to_sym).id)
      @schoolarship.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Schoolarship.find(schoolarships(schoolarship.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @schoolarship = Schoolarship.new
    assert !@schoolarship.save
  end

  def test_creating_duplicated_schoolarship
    @schoolarship = Schoolarship.new({:name => 'Dirección General de Asuntos del Personal Académico', :institution_id => 1})
    assert !@schoolarship.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myschoolarship.id = 1.6
    assert !@myschoolarship.valid?
    @myschoolarship.id = 'mi_id_texto'
    assert !@myschoolarship.valid?
  end

  def test_bad_values_for_name
    @myschoolarship.name = nil
    assert !@myschoolarship.valid?
  end


  # Checking constraints for institution_id
  def test_bad_values_for_institution_id
    @myschoolarship.institution_id = nil
    assert !@myschoolarship.valid?
    @myschoolarship.institution_id = 3.1416
    assert !@myschoolarship.valid?
    @myschoolarship.institution_id = 'mi_id_texto'
    assert !@myschoolarship.valid?
  end

  #Cross-Checking test for institution_id
  def test_cross_checking_for_institution_id
    @schoolarships.each { | schoolarship|
      @schoolarship = Schoolarship.find(schoolarships(schoolarship.to_sym).id)
      assert_kind_of Schoolarship, @schoolarship
      assert_equal @schoolarship.institution_id, Institution.find(@schoolarship.institution_id).id
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
    @schoolarships.each { | schoolarship|
      @schoolarship = Schoolarship.find(schoolarships(schoolarship.to_sym).id)
      assert_kind_of Schoolarship, @schoolarship
      @schoolarship.institution_id = 500000
      begin
        return true if @schoolarship.save
      rescue StandardError => x
        return false
      end
    }
  end

end
