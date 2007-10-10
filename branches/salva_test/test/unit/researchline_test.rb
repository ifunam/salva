require File.dirname(__FILE__) + '/../test_helper'
require 'researcharea'
require 'researchline'

class ResearchlineTest < Test::Unit::TestCase
  fixtures :researchareas, :researchlines
  include UnitSimple

  def setup
    @researchlines = %w(fuente_sismica sismotectonica propagacion_de_ondas)
    @myresearchline = Researchline.new({:name => 'Estructura cortical', :researcharea_id => 1})
  end

  # Right - CRUD
  def test_creating_researchlines_from_yaml
    @researchlines.each { | researchline|
      @researchline = Researchline.find(researchlines(researchline.to_sym).id)
      assert_kind_of Researchline, @researchline
      assert_equal researchlines(researchline.to_sym).name, @researchline.name
      assert_equal researchlines(researchline.to_sym).id, @researchline.id
    }
  end

  def test_updating_researchlines_name
    @researchlines.each { |researchline|
      @researchline = Researchline.find(researchlines(researchline.to_sym).id)
      assert_equal researchlines(researchline.to_sym).name, @researchline.name
      @researchline.name = @researchline.name.chars.reverse
      assert @researchline.save
      assert_not_equal researchlines(researchline.to_sym).name, @researchline.name
    }
  end

  def test_deleting_researchlines
    @researchlines.each { |researchline|
      @researchline = Researchline.find(researchlines(researchline.to_sym).id)
      @researchline.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Researchline.find(researchlines(researchline.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @researchline = Researchline.new
    assert !@researchline.save
  end

  def test_creating_duplicated_researchline
    @researchline = Researchline.new({:name => 'Fuente sísmica', :id => 1})
    assert !@researchline.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myresearchline.id = 1.6
    assert !@myresearchline.valid?
  end

  def test_bad_values_for_name
    @myresearchline.name = nil
    assert !@myresearchline.valid?
  end

  def test_bad_values_for_researchline_id
    @myresearchline.id = 3.1416
    assert !@myresearchline.valid?

    @myresearchline.id = 'xx'
    assert !@myresearchline.valid?
    @myresearchline.id = -3.0
    assert !@myresearchline.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_researcharea_id
    @researchlines.each { | researchline|
      @myresearchline = Researchline.find(researchlines(researchline.to_sym).id)
      assert_kind_of Researchline, @myresearchline
      assert_equal @myresearchline.id, Researcharea.find(@myresearchline.id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_researcharea_id
    @researchlines.each { | researchline|
      @myresearchline = Researchline.find(researchlines(researchline.to_sym).id)
      assert_kind_of Researchline, @myresearchline
      @myresearchline.id = 100
      begin
        return true if @myresearchline.save
      rescue StandardError => x
        return false
      end
    }
  end
end
