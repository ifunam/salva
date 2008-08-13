require File.dirname(__FILE__) + '/../test_helper'
require 'thesismodality'
require 'thesisstatus'
require 'thesis'
require 'institutioncareer'



class ThesisTest < Test::Unit::TestCase
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :thesismodalities, :thesisstatuses, :theses

  def setup
    @theses = %w(estudio_de_eventos_transitorios_economico-sociales_en_mexico investigacion_sobre_la_administracion_publica_en_la_unam)
    @mythesis = Thesis.new({ :title => 'Seguridad en documentos con sellos digitales', :authors => ' Miguel Angel Vazquez Villarreal',  :institutioncareer_id => 2, :thesisstatus_id => 1,  :thesismodality_id => 1,:startyear =>  2007})
  end

  # Right - CRUD
  def test_creating_thesis_from_yaml
    @theses.each { | thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      assert_kind_of Thesis, @thesis
      assert_equal theses(thesis.to_sym).id, @thesis.id
      assert_equal theses(thesis.to_sym).thesisstatus_id, @thesis.thesisstatus_id
      assert_equal theses(thesis.to_sym).title, @thesis.title
      assert_equal theses(thesis.to_sym).authors, @thesis.authors
      assert_equal theses(thesis.to_sym).institutioncareer_id, @thesis.institutioncareer_id
      assert_equal theses(thesis.to_sym).thesismodality_id, @thesis.thesismodality_id

    }
  end

  def test_updating_thesis_id
    @theses.each { |thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      assert_equal theses(thesis.to_sym).title, @thesis.title
      @thesis.title = @thesis.title.chars.reverse
      assert @thesis.save
      assert_not_equal theses(thesis.to_sym).title, @thesis.title
    }
  end

    def test_updating_thesestatus_id
    @theses.each { |thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      assert_equal theses(thesis.to_sym).thesisstatus_id, @thesis.thesisstatus_id
      @thesis.thesisstatus_id = 3
      assert @thesis.save
      assert_not_equal theses(thesis.to_sym).thesisstatus_id, @thesis.thesisstatus_id
    }
  end

    def test_updating_authors
    @theses.each { |thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      assert_equal theses(thesis.to_sym).authors, @thesis.authors
      @thesis.authors = @thesis.authors.chars.reverse
      assert @thesis.save
      assert_not_equal theses(thesis.to_sym).authors, @thesis.authors
    }
  end

  def test_deleting_theses
    @theses.each { |thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      @thesis.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Thesis.find(theses(thesis.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @thesis = Thesis.new
    assert !@thesis.save
  end

   def test_creating_duplicated
     @thesis = Thesis.new({ :title => 'Estudio de eventos transitorios economico-sociales en Mexico', :authors => 'Arturo Mendiolea', :institutioncareer_id => 1, :thesisstatus_id => 2,  :thesismodality_id => 1,:startyear =>  2006})
      assert !@thesis.save
    end

   # Boundary
   def test_bad_values_for_id
     @mythesis.id = 1.6
     assert !@mythesis.valid?
     @mythesis.id = 'mi_id'
     assert !@mythesis.valid?
   end

   def test_bad_values_for_thesisstatus_id
     @mythesis.thesisstatus_id = nil
     assert !@mythesis.valid?
     @mythesis.thesisstatus_id = 1.6
     assert !@mythesis.valid?
     @mythesis.thesisstatus_id = 'my_year'
     assert !@mythesis.valid?
   end

   def test_bad_values_for_thesisyear
     @mythesis.startyear = nil
     assert !@mythesis.valid?
     @mythesis.startyear = 15015.36
     assert !@mythesis.valid?
     @mythesis.startyear = 'my_year'
     assert !@mythesis.valid?
   end

   def test_bad_values_for_thesismodality_id
     @mythesis.thesismodality_id = nil
     assert !@mythesis.valid?
     @mythesis.thesismodality_id = 15015.36
     assert !@mythesis.valid?
     @mythesis.thesismodality_id = 'my_year'
     assert !@mythesis.valid?
   end

   def test_bad_values_for_thesisinstitutioncareer_id
     @mythesis.institutioncareer_id = nil
     assert !@mythesis.valid?
     @mythesis.institutioncareer_id = 15015.36
     assert !@mythesis.valid?
     @mythesis.institutioncareer_id = 'my_year'
     assert !@mythesis.valid?
   end


  #cross-Checking test for thesis



  def test_cross_checking_for_thesestatus_id
    @theses.each { | thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      assert_kind_of Thesis, @thesis
      assert_equal @thesis.thesisstatus_id, Thesisstatus.find(@thesis.thesisstatus_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_thesisstatus_id
    @theses.each { | thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      assert_kind_of Thesis, @thesis
      @thesis.thesisstatus_id = 10
       begin
        return true if @thesis.update
       rescue StandardError => x
        return false
      end
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end


def test_cross_checking_for_institutioncareer_id
    @theses.each { | thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      assert_kind_of Thesis, @thesis
      assert_equal @thesis.institutioncareer_id, Institutioncareer.find(@thesis.institutioncareer_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institutioncareer_id
    @theses.each { | thesis|
      @thesis = Thesis.find(theses(thesis.to_sym).id)
      assert_kind_of Thesis, @thesis
      @thesis.institutioncareer_id = 80
          begin
        return true if @thesis.save
           rescue StandardError => x
        return false
      end
    }
  end


end
