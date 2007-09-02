require File.dirname(__FILE__) + '/../test_helper'
require 'schooling'
require 'titlemodality'
require 'professionaltitle'

class ProfessionaltitleTest < Test::Unit::TestCase
  fixtures   :countries, :states, :cities, :institutiontitles,:institutiontypes, :degrees, :careers, :institutions, :schoolarships, :careers, :userstatuses, :users, :institutioncareers, :schoolings, :titlemodalities, :professionaltitles

  def setup
    @professionaltitles = %w(unam_tesis_panchito unam_tesina_juana)
    @myprofessionaltitle = Professionaltitle.new({:schooling_id => 1, :titlemodality_id => 2})
  end

  # Right - CRUD
  def test_creating_professionaltitles_from_yaml
    @professionaltitles.each { | professionaltitle|
      @professionaltitle = Professionaltitle.find(professionaltitles(professionaltitle.to_sym).id)
      assert_kind_of Professionaltitle, @professionaltitle
      assert_equal professionaltitles(professionaltitle.to_sym).id, @professionaltitle.id
      assert_equal professionaltitles(professionaltitle.to_sym).titlemodality_id, @professionaltitle.titlemodality_id
      assert_equal professionaltitles(professionaltitle.to_sym).schooling_id, @professionaltitle.schooling_id
    }
  end

  def test_deleting_professionaltitles
    @professionaltitles.each { |professionaltitle|
      @professionaltitle = Professionaltitle.find(professionaltitles(professionaltitle.to_sym).id)
      @professionaltitle.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Professionaltitle.find(professionaltitles(professionaltitle.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @professionaltitle = Professionaltitle.new
    assert !@professionaltitle.save
  end

  def test_creating_duplicated_professionaltitle
    @professionaltitle = Professionaltitle.new({:schooling_id => 2, :titlemodality_id => 2})
    assert !@professionaltitle.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprofessionaltitle.id = 1.6
    assert !@myprofessionaltitle.valid?
    @myprofessionaltitle.id = 'mi_id'
    assert !@myprofessionaltitle.valid?
  end

  def test_bad_values_for_titlemodality_id
    @myprofessionaltitle.titlemodality_id = nil
    assert !@myprofessionaltitle.valid?

    @myprofessionaltitle.titlemodality_id= 1.6
    assert !@myprofessionaltitle.valid?

    @myprofessionaltitle.titlemodality_id = 'mi_id'
    assert !@myprofessionaltitle.valid?
  end

  def test_bad_values_for_schooling_id
    @myprofessionaltitle.schooling_id = nil
    assert !@myprofessionaltitle.valid?

    @myprofessionaltitle.schooling_id = 3.1416
    assert !@myprofessionaltitle.valid?
    @myprofessionaltitle.schooling_id = 'mi_id'
    assert !@myprofessionaltitle.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_schooling_id
    @professionaltitles.each { | professionaltitle|
      @professionaltitle = Professionaltitle.find(professionaltitles(professionaltitle.to_sym).id)
      assert_kind_of Professionaltitle, @professionaltitle
      assert_equal @professionaltitle.schooling_id, Schooling.find(@professionaltitle.schooling_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_schooling_id
    @professionaltitles.each { | professionaltitle|
      @professionaltitle = Professionaltitle.find(professionaltitles(professionaltitle.to_sym).id)
      assert_kind_of Professionaltitle, @professionaltitle
      @professionaltitle.schooling_id = 1000000
      begin
        return true if @professionaltitle.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_titlemodality_id
    @professionaltitles.each { | professionaltitle|
      @professionaltitle = Professionaltitle.find(professionaltitles(professionaltitle.to_sym).id)

      assert_kind_of Professionaltitle, @professionaltitle
      assert_equal @professionaltitle.titlemodality_id, Titlemodality.find(@professionaltitle.titlemodality_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_titlemodality_id
    @professionaltitles.each { | professionaltitle|
      @professionaltitle = Professionaltitle.find(professionaltitles(professionaltitle.to_sym).id)
      assert_kind_of Professionaltitle, @professionaltitle
      @professionaltitle.titlemodality_id = 100000
      begin
        return true if @professionaltitle.update
      rescue StandardError => x
        return false
      end
    }
  end

end