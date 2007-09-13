require File.dirname(__FILE__) + '/../test_helper'
require 'acadvisit'
require 'user'
require 'institution'
require 'sponsor_acadvisit'

class SponsorAcadvisitTest < Test::Unit::TestCase
  fixtures :userstatuses, :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :degrees, :careers, :institutioncareers,  :users, :acadvisittypes, :acadvisits, :sponsor_acadvisits

  def setup
    @sponsor_acadvisits = %w(instituto_de_geofisica centro_de_ciencias_de_la_atmosfera)
    @mysponsor_acadvisit = SponsorAcadvisit.new({ :acadvisit_id => 3, :institution_id => 2, :amount => 2})
  end

  # Right - CRUD
  def test_creating_sponsor_acadvisit_from_yaml
    @sponsor_acadvisits.each { | sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      assert_kind_of SponsorAcadvisit, @sponsor_acadvisit
      assert_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).id, @sponsor_acadvisit.id
      assert_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).acadvisit_id, @sponsor_acadvisit.acadvisit_id
      assert_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).institution_id, @sponsor_acadvisit.institution_id
      assert_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).amount, @sponsor_acadvisit.amount
    }
  end

  def test_updating_acadvisit_id
    @sponsor_acadvisits.each { |sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      assert_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).acadvisit_id, @sponsor_acadvisit.acadvisit_id
      @sponsor_acadvisit.acadvisit_id == 1 ? @sponsor_acadvisit.acadvisit_id = @sponsor_acadvisit.acadvisit_id + 1 :@sponsor_acadvisit.acadvisit_id =  @sponsor_acadvisit.acadvisit_id - 1
      assert @sponsor_acadvisit.update
      assert_not_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).acadvisit_id, @sponsor_acadvisit.acadvisit_id
    }
  end

   def test_updating_institution_id
    @sponsor_acadvisits.each { |sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      assert_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).institution_id, @sponsor_acadvisit.institution_id
      @sponsor_acadvisit.institution_id = 71
      assert @sponsor_acadvisit.update
      assert_not_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).institution_id, @sponsor_acadvisit.institution_id
    }
  end

   def test_updating_amount
    @sponsor_acadvisits.each { |sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      assert_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).amount, @sponsor_acadvisit.amount
      @sponsor_acadvisit.amount = 1000000
      assert @sponsor_acadvisit.update
      assert_not_equal sponsor_acadvisits(sponsor_acadvisit.to_sym).amount, @sponsor_acadvisit.amount
    }
  end

  def test_deleting_sponsor_acadvisits
    @sponsor_acadvisits.each { |sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      @sponsor_acadvisit.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @sponsor_acadvisit = SponsorAcadvisit.new
    assert !@sponsor_acadvisit.save
  end

   # Boundary
    def test_bad_values_for_id
     @mysponsor_acadvisit.id = 1.6
     assert !@mysponsor_acadvisit.valid?
     @mysponsor_acadvisit.id = 'mi_id'
     assert !@mysponsor_acadvisit.valid?
  end

  def test_bad_values_for_acadvisit_id
    @mysponsor_acadvisit.acadvisit_id= nil
    assert !@mysponsor_acadvisit.valid?
    @mysponsor_acadvisit.acadvisit_id= 1.6
    assert !@mysponsor_acadvisit.valid?
    @mysponsor_acadvisit.acadvisit_id = 'mi_id_texto'
    assert !@mysponsor_acadvisit.valid?
  end

  def test_bad_values_for_institution_id
    @mysponsor_acadvisit.institution_id = nil
    assert !@mysponsor_acadvisit.valid?
    @mysponsor_acadvisit.institution_id = 1.6
    assert !@mysponsor_acadvisit.valid?
    @mysponsor_acadvisit.institution_id = 'mi_id_texto'
    assert !@mysponsor_acadvisit.valid?
  end

def test_bad_values_for_amount
    @mysponsor_acadvisit.amount = nil
    assert !@mysponsor_acadvisit.valid?
    @mysponsor_acadvisit.amount = 'mi_id_texto'
    assert !@mysponsor_acadvisit.valid?
  end

  #cross-Checking test for acadvisit
  def test_cross_checking_for_acadvisit_id
    @sponsor_acadvisits.each { | sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      assert_kind_of SponsorAcadvisit, @sponsor_acadvisit
      assert_equal @sponsor_acadvisit.acadvisit_id, Acadvisit.find(@sponsor_acadvisit.acadvisit_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_acadvisit_id
    @sponsor_acadvisits.each { | sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      assert_kind_of SponsorAcadvisit, @sponsor_acadvisit
      @sponsor_acadvisit.acadvisit_id = 5000
      begin
        return true if @sponsor_acadvisit.update
           rescue StandardError => x
        return false
      end
    }
  end

    #cross-Checking test for institution
  def test_cross_checking_for_institution_id
    @sponsor_acadvisits.each { | sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      assert_kind_of SponsorAcadvisit, @sponsor_acadvisit
      assert_equal @sponsor_acadvisit.institution_id, Institution.find(@sponsor_acadvisit.institution_id).id
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
    @sponsor_acadvisits.each { | sponsor_acadvisit|
      @sponsor_acadvisit = SponsorAcadvisit.find(sponsor_acadvisits(sponsor_acadvisit.to_sym).id)
      assert_kind_of SponsorAcadvisit, @sponsor_acadvisit
      @sponsor_acadvisit.institution_id = 100000
      begin
        return true if @sponsor_acadvisit.update
           rescue StandardError => x
        return false
      end
    }
  end
end
