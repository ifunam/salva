require File.dirname(__FILE__) + '/../test_helper'
require 'newspaperarticle'
require 'newspaper'

class NewspaperarticleTest < Test::Unit::TestCase
  fixtures :countries, :newspapers,  :newspaperarticles

  def setup
    @newspaperarticles = %w(el_viento_solar_causa_tormentas_geomagneticas_en_la_ultima_semana pruebas_de_mantenimiento_del_radiotelescopio)
    @mynewspaperarticle = Newspaperarticle.new({:title => 'el viento solar tormentas', :newspaper_id => 1, :newsdate => "2007-09-03", :authors  => 'Jose Perales'})
  end

  # Right - CRUD
  def test_creating_newspaperarticles_from_yaml
    @newspaperarticles.each { | newspaperarticle|
      @newspaperarticle = Newspaperarticle.find(newspaperarticles(newspaperarticle.to_sym).id)
      assert_kind_of Newspaperarticle, @newspaperarticle
      assert_equal newspaperarticles(newspaperarticle.to_sym).id, @newspaperarticle.id
      assert_equal newspaperarticles(newspaperarticle.to_sym).title, @newspaperarticle.title
      assert_equal newspaperarticles(newspaperarticle.to_sym).newspaper_id, @newspaperarticle.newspaper_id
    }
  end

  def test_updating_newspaperarticles_title
    @newspaperarticles.each { |newspaperarticle|
      @newspaperarticle = Newspaperarticle.find(newspaperarticles(newspaperarticle.to_sym).id)
      assert_equal newspaperarticles(newspaperarticle.to_sym).title, @newspaperarticle.title
      @newspaperarticle.title = @newspaperarticle.title.chars.reverse
      assert @newspaperarticle.save
      assert_not_equal newspaperarticles(newspaperarticle.to_sym).title, @newspaperarticle.title
    }
  end

  def test_deleting_newspaperarticles
    @newspaperarticles.each { |newspaperarticle|
      @newspaperarticle = Newspaperarticle.find(newspaperarticles(newspaperarticle.to_sym).id)
      @newspaperarticle.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Newspaperarticle.find(newspaperarticles(newspaperarticle.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @newspaperarticle = Newspaperarticle.new
    assert !@newspaperarticle.save
  end

  def test_creating_duplicated_newspaperarticle
    @newspaperarticle = Newspaperarticle.new({:title => 'El viento solar causa tormentas geomagneticas en la ultima semana', :newspaper_id => 2, :newsdate => "2004-08-03", :authors  => 'Juan Jose Romero'})
    assert !@newspaperarticle.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mynewspaperarticle.id = 1.6
    assert !@mynewspaperarticle.valid?

    # Negative numbers
    @mynewspaperarticle.id = -1
    assert !@mynewspaperarticle.valid?
  end

  def test_bad_values_for_title
    @mynewspaperarticle.title = nil
    assert !@mynewspaperarticle.valid?
  end

  def test_bad_values_for_newspaper_id
    # Checking constraints for title
    # Nil title
    @mynewspaperarticle.newspaper_id = nil
    assert !@mynewspaperarticle.valid?

    # Float number for ID
    @mynewspaperarticle.newspaper_id = 3.1416
    assert !@mynewspaperarticle.valid?

    # Negative numbers
    @mynewspaperarticle.newspaper_id = -1
    assert !@mynewspaperarticle.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_newspaper_id
    @newspaperarticles.each { | newspaperarticle|
      @newspaperarticle = Newspaperarticle.find(newspaperarticles(newspaperarticle.to_sym).id)
      assert_kind_of Newspaperarticle, @newspaperarticle
      assert_equal @newspaperarticle.newspaper_id, Newspaper.find(@newspaperarticle.newspaper_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_newspaper_id
    @newspaperarticles.each { | newspaperarticle|
      @newspaperarticle = Newspaperarticle.find(newspaperarticles(newspaperarticle.to_sym).id)
      assert_kind_of Newspaperarticle, @newspaperarticle
      @newspaperarticle.newspaper_id = 2000
      begin
        return true if @newspaperarticle.save
      rescue StandardError => x
        return false
      end
    }
  end
end
