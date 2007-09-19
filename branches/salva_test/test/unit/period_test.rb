require File.dirname(__FILE__) + '/../test_helper'
require 'period'

class PeriodTest < Test::Unit::TestCase
  fixtures :periods
  def setup
    @periods = %w(ordinario extraordiniario otro)
    @myperiod = Period.new({:title => 'Regular', :startdate  => '1966-06-01', :enddate  => '1966-12-20'})
  end

  # Right - CRUD
  def test_creating_from_yaml
    @periods.each { | period|
      @period = Period.find(periods(period.to_sym).id)
      assert_kind_of Period, @period
      assert_equal periods(period.to_sym).id, @period.id
      assert_equal periods(period.to_sym).title, @period.title
      assert_equal periods(period.to_sym).startdate, @period.startdate
      assert_equal periods(period.to_sym).enddate, @period.enddate
    }
  end

  def test_updating_title
    @periods.each { |period|
      @period = Period.find(periods(period.to_sym).id)
      assert_equal periods(period.to_sym).title, @period.title
      @period.title = @period.title.chars.reverse
      assert @period.update
      assert_not_equal periods(period.to_sym).title, @period.title
    }
  end

  def test_deleting
    @periods.each { |period|
      @period = Period.find(periods(period.to_sym).id)
      @period.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Period.find(periods(period.to_sym).id)
      }
    }
  end

  def test_uniqueness
    @period = Period.new({:title => 'Ordinario', :startdate  => '2006-06-01', :enddate  => '2006-12-10' })
    assert !@period.save
  end

  def test_empty_object
    @period = Period.new()
    assert !@period.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myperiod.id = 'xx'
    assert !@myperiod.valid?

    # Negative number ID
    #@myperiod.id = -1
    #assert !@myperiod.valid?

    # Float number ID
    @myperiod.id = 1.3
    assert !@myperiod.valid?
  end

  def test_bad_values_for_title
    # Nil title
    @myperiod.title = nil
    assert !@myperiod.valid?
  end

   def test_bad_values_for_periods
    @myperiod.startdate = nil
    assert !@myperiod.valid?
    @myperiod.enddate = nil
    assert !@myperiod.valid?

    @myperiod.startdate = '1976-06-01'
    @myperiod.enddate = '1966-12-20'
    assert !@myperiod.valid?
  end
end