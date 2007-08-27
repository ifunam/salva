require File.dirname(__FILE__) + '/../test_helper'

require 'conference'
require 'proceeding'

class ProceedingTest < Test::Unit::TestCase
  fixtures  :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings

  def setup
    @proceedings = %w(characterizacion_of_position_sensitive coloquio_de_artes_manuales_y_otras_habilidades)
    @myproceeding = Proceeding.new({:conference_id => 3, :title => 'Radiation Hardness test', :isrefereed => false })
  end

  # Right - CRUD
  def test_creating_proceedings_from_yaml
    @proceedings.each { | proceeding|
      @proceeding = Proceeding.find(proceedings(proceeding.to_sym).id)
      assert_kind_of Proceeding, @proceeding
      assert_equal proceedings(proceeding.to_sym).id, @proceeding.id
      assert_equal proceedings(proceeding.to_sym).conference_id, @proceeding.conference_id
      assert_equal proceedings(proceeding.to_sym).isrefereed, @proceeding.isrefereed
      assert_equal proceedings(proceeding.to_sym).title, @proceeding.title
    }
  end

  def test_deleting_proceedings
    @proceedings.each { |proceeding|
      @proceeding = Proceeding.find(proceedings(proceeding.to_sym).id)
      @proceeding.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Proceeding.find(proceedings(proceeding.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @proceeding = Proceeding.new
    assert !@proceeding.save
  end

  def test_creating_duplicated_proceeding
    @proceeding = Proceeding.new({:conference_id => 2, :title => 'Coloquio de Artes Manuales y otras habilidades', :isrefereed => false})
    assert !@proceeding.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myproceeding.id = 1.6
    assert !@myproceeding.valid?
    @myproceeding.id = 'mi_id'
    assert !@myproceeding.valid?
  end

  def test_bad_values_for_conference_id
    @myproceeding.conference_id = nil
    assert !@myproceeding.valid?

    @myproceeding.conference_id= 1.6
    assert !@myproceeding.valid?

    @myproceeding.conference_id = 'mi_id'
    assert !@myproceeding.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_conference_id
    @proceedings.each { | proceeding|
      @proceeding = Proceeding.find(proceedings(proceeding.to_sym).id)

      assert_kind_of Proceeding, @proceeding
      assert_equal @proceeding.conference_id, Conference.find(@proceeding.conference_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_conference_id
    @proceedings.each { | proceeding|
      @proceeding = Proceeding.find(proceedings(proceeding.to_sym).id)
      assert_kind_of Proceeding, @proceeding
      @proceeding.conference_id = 1000000
      begin
        return true if @proceeding.update
      rescue StandardError => x
        return false
      end
    }
  end
  def test_bad_values_for_isrefereed
    @myproceeding = Proceeding.new
    @myproceeding.isrefereed = "texto"
    assert !@myproceeding.valid?
  end
end
