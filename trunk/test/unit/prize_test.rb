require File.dirname(__FILE__) + '/../test_helper'
require 'prizetype'
require 'institution'
require 'prize'

class PrizeTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :prizetypes, :prizes
  def setup
    @prizes = %w(ciencia_mexico mejor_estudio_de_genero)
    @myprize = Prize.new({:name => 'Mejor Investigacion', :institution_id => 2, :prizetype_id => 1})
  end

  # Right - CRUD
  def test_creating_from_yaml
    @prizes.each { | prize|
      @prize = Prize.find(prizes(prize.to_sym).id)
      assert_kind_of Prize, @prize
      assert_equal prizes(prize.to_sym).id, @prize.id
      assert_equal prizes(prize.to_sym).name, @prize.name
      assert_equal prizes(prize.to_sym).prizetype_id, @prize.prizetype_id
      assert_equal prizes(prize.to_sym).institution_id, @prize.institution_id
    }
  end

  def test_updating_prizes_name
    @prizes.each { |prize|
      @prize = Prize.find(prizes(prize.to_sym).id)
      assert_equal prizes(prize.to_sym).name, @prize.name
      @prize.name = @prize.name.chars.reverse
      assert @prize.update
      assert_not_equal prizes(prize.to_sym).name, @prize.name
    }
  end

  def test_deleting_prizes
    @prizes.each { |prize|
      @prize = Prize.find(prizes(prize.to_sym).id)
      @prize.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Prize.find(prizes(prize.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @prize = Prize.new
    assert !@prize.save
  end

  def test_creating_duplicated_prize
    @prize = Prize.new({:name => 'CIENCIA MEXICO', :institution_id => 1, :prizetype_id => 2})
    assert !@prize.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprize.id = 1.6
    assert !@myprize.valid?
    @myprize.id = 'mi_id_texto'
    assert !@myprize.valid?
  end

  def test_bad_values_for_name
    @myprize.name = nil
    assert !@myprize.valid?
  end

  # Checking constraints for institution_id
  def test_bad_values_for_institution_id
    @myprize.institution_id = nil
    assert !@myprize.valid?
    @myprize.institution_id = 3.1416
    assert !@myprize.valid?
    @myprize.institution_id = 'mi_id_texto'
    assert !@myprize.valid?
  end

  # Checking constraints for prizetype_id
  def test_bad_values_for_prizetype_id
    @myprize.prizetype_id = nil
    assert !@myprize.valid?
    @myprize.prizetype_id = 3.1416
    assert !@myprize.valid?
    @myprize.prizetype_id = 'mi_id_texto'
    assert !@myprize.valid?
  end

  #Cross-Checking test for institution_id
  def test_cross_checking_for_institution_id
    @prizes.each { | prize|
      @prize = Prize.find(prizes(prize.to_sym).id)
      assert_kind_of Prize, @prize
      assert_equal @prize.institution_id, Institution.find(@prize.institution_id).id
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
    @prizes.each { | prize|
      @prize = Prize.find(prizes(prize.to_sym).id)
      assert_kind_of Prize, @prize
      @prize.institution_id = 500000
      begin
        return true if @prize.update
      rescue StandardError => x
        return false
      end
    }
  end

  #Cross-Checking test for prizetype_id
  def test_cross_checking_for_prizetype_id
    @prizes.each { | prize|
      @prize = Prize.find(prizes(prize.to_sym).id)
      assert_kind_of Prize, @prize
      assert_equal @prize.prizetype_id, Prizetype.find(@prize.prizetype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_prize_id
    @prizes.each { | prize|
      @prize = Prize.find(prizes(prize.to_sym).id)
      assert_kind_of Prize, @prize
      @prize.prizetype_id = 1000
      begin
        return true if @prize.update
      rescue StandardError => x
        return false
      end
    }
  end
end
