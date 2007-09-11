require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'institution'
require 'instadvicetarget'
require 'instadvice'

class InstadviceTest < Test::Unit::TestCase
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :userstatuses, :users, :instadvicetargets, :instadvices

  def setup
    @instadvices = %w(cursos_de_capacitacion_en_computo operacion_de_equipos_de_computo)
    @myinstadvice = Instadvice.new({:title => 'Asesoría en Microscopía',:user_id => 2, :institution_id => 57, :instadvicetarget_id => 3, :year => 2007})
  end

  # Right - CRUD
  def test_creating_instadvices_from_yaml
    @instadvices.each { | instadvice|
      @instadvice = Instadvice.find(instadvices(instadvice.to_sym).id)
      assert_kind_of Instadvice, @instadvice
      assert_equal instadvices(instadvice.to_sym).id, @instadvice.id
      assert_equal instadvices(instadvice.to_sym).instadvicetarget_id, @instadvice.instadvicetarget_id
      assert_equal instadvices(instadvice.to_sym).institution_id, @instadvice.institution_id
      assert_equal instadvices(instadvice.to_sym).user_id, @instadvice.user_id
      assert_equal instadvices(instadvice.to_sym).title, @instadvice.title
      assert_equal instadvices(instadvice.to_sym).year, @instadvice.year
    }
  end

  def test_updating_instadvice_title
    @instadvices.each { |instadvice|
      @instadvice = Instadvice.find(instadvices(instadvice.to_sym).id)
      assert_equal instadvices(instadvice.to_sym).title, @instadvice.title
      @instadvice.title = @instadvice.title.chars.reverse
      assert @instadvice.update
      assert_not_equal instadvices(instadvice.to_sym).title, @instadvice.title
    }
  end

  def test_deleting_instadvices
    @instadvices.each { |instadvice|
      @instadvice = Instadvice.find(instadvices(instadvice.to_sym).id)
      @instadvice.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Instadvice.find(instadvices(instadvice.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @instadvice = Instadvice.new
    assert !@instadvice.save
  end

  #def test_creating_duplicated_instadvice
  #  @instadvice = Instadvice.new({:title => 'Operacion de equipos de computo',:user_id => 3, :institution_id => 5588, :instadvicetarget_id => 3, :year => 2005})
  #  assert !@instadvice.save
  #end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myinstadvice.id = 1.6
    assert !@myinstadvice.valid?
    @myinstadvice.id = 'mi_id'
    assert !@myinstadvice.valid?
  end

  def test_bad_values_for_instadvicetarget_id
    @myinstadvice.instadvicetarget_id = nil
    assert !@myinstadvice.valid?

    @myinstadvice.instadvicetarget_id= 1.6
    assert !@myinstadvice.valid?

    @myinstadvice.instadvicetarget_id = 'mi_id'
    assert !@myinstadvice.valid?
  end

  def test_bad_values_for_institution_id
    @myinstadvice.institution_id = nil
    assert !@myinstadvice.valid?

    @myinstadvice.institution_id = 3.1416
    assert !@myinstadvice.valid?
    @myinstadvice.institution_id = 'mi_id'
    assert !@myinstadvice.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_institution_id
    @instadvices.each { | instadvice|
      @instadvice = Instadvice.find(instadvices(instadvice.to_sym).id)
      assert_kind_of Instadvice, @instadvice
      assert_equal @instadvice.institution_id, Institution.find(@instadvice.institution_id).id
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
    @instadvices.each { | instadvice|
      @instadvice = Instadvice.find(instadvices(instadvice.to_sym).id)
      assert_kind_of Instadvice, @instadvice
      @instadvice.institution_id = 1000000
      begin
        return true if @instadvice.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_instadvicetarget_id
    @instadvices.each { | instadvice|
      @instadvice = Instadvice.find(instadvices(instadvice.to_sym).id)

      assert_kind_of Instadvice, @instadvice
      assert_equal @instadvice.instadvicetarget_id, Instadvicetarget.find(@instadvice.instadvicetarget_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_instadvicetarget_id
    @instadvices.each { | instadvice|
      @instadvice = Instadvice.find(instadvices(instadvice.to_sym).id)
      assert_kind_of Instadvice, @instadvice
      @instadvice.instadvicetarget_id = 100000
      begin
        return true if @instadvice.update
      rescue StandardError => x
        return false
      end
    }
  end

end
