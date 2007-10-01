require File.dirname(__FILE__) + '/../test_helper'

require 'proceeding'
require 'inproceeding'

class InproceedingTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings, :inproceedings

  def setup
    @inproceedings = %w(variation_of_the_magnitude_and_phase_of_the_recorded_complex_refraction_index recent_developments_in_linear_stochastic_electrodynamics)
    @myinproceeding = Inproceeding.new({ :proceeding_id => 3, :title => 'Star polyhedral gold nanocrystals.',  :authors => 'Burt JL, Reyes Gasca J., Jose-Yacaman M'})
  end

  # Right - CRUD
  def test_creating_inproceedings_from_yaml
    @inproceedings.each { | inproceeding|
      @inproceeding = Inproceeding.find(inproceedings(inproceeding.to_sym).id)
      assert_kind_of Inproceeding, @inproceeding
      assert_equal inproceedings(inproceeding.to_sym).id, @inproceeding.id
      assert_equal inproceedings(inproceeding.to_sym).proceeding_id, @inproceeding.proceeding_id
      assert_equal inproceedings(inproceeding.to_sym).title, @inproceeding.title
      assert_equal inproceedings(inproceeding.to_sym).authors, @inproceeding.authors
    }
  end

def test_updating_inproceedings_title
    @inproceedings.each { |inproceeding|
      @inproceeding = Inproceeding.find(inproceedings(inproceeding.to_sym).id)
      assert_equal inproceedings(inproceeding.to_sym).title, @inproceeding.title
      @inproceeding.title = @inproceeding.title.chars.reverse
      assert @inproceeding.save
      assert_not_equal inproceedings(inproceeding.to_sym).title, @inproceeding.title
    }
  end

  def test_updating_inproceedings_authors
    @inproceedings.each { |inproceeding|
      @inproceeding = Inproceeding.find(inproceedings(inproceeding.to_sym).id)
      assert_equal inproceedings(inproceeding.to_sym).authors, @inproceeding.authors
      @inproceeding.authors = @inproceeding.authors.chars.reverse
      assert @inproceeding.save
      assert_not_equal inproceedings(inproceeding.to_sym).authors, @inproceeding.authors
    }
  end

  def test_deleting_inproceedings
    @inproceedings.each { |inproceeding|
      @inproceeding = Inproceeding.find(inproceedings(inproceeding.to_sym).id)
      @inproceeding.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Inproceeding.find(inproceedings(inproceeding.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @inproceeding = Inproceeding.new
    assert !@inproceeding.save
  end

  def test_creating_duplicated_inproceeding
    @inproceeding = Inproceeding.new({ :proceeding_id => 1, :title => 'Variation of the magnitude and phase of the recorded complex refraction index along waves propagation in sillenites',  :authors => 'Casar I. Magaña F, Murillo J, Farías R, Zúñiga A'})
    assert !@inproceeding.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myinproceeding.id = 1.6
    assert !@myinproceeding.valid?
    @myinproceeding.id = 'mi_id'
    assert !@myinproceeding.valid?
  end

  def test_bad_values_for_proceeding_id
    @myinproceeding.proceeding_id = nil
    assert !@myinproceeding.valid?

    @myinproceeding.proceeding_id= 1.6
    assert !@myinproceeding.valid?

    @myinproceeding.proceeding_id = 'mi_id'
    assert !@myinproceeding.valid?
  end


  def test_cross_checking_for_proceeding_id
    @inproceedings.each { | inproceeding|
      @inproceeding = Inproceeding.find(inproceedings(inproceeding.to_sym).id)

      assert_kind_of Inproceeding, @inproceeding
      assert_equal @inproceeding.proceeding_id, Proceeding.find(@inproceeding.proceeding_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_proceeding_id
    @inproceedings.each { | inproceeding|
      @inproceeding = Inproceeding.find(inproceedings(inproceeding.to_sym).id)
      assert_kind_of Inproceeding, @inproceeding
      @inproceeding.proceeding_id = 100000
      begin
        return true if @inproceeding.save
      rescue StandardError => x
        return false
      end
    }
  end

end
