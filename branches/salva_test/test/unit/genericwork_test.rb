require File.dirname(__FILE__) + '/../test_helper'
require 'genericworktype'
require 'genericworkstatus'
require 'genericwork'


class GenericworkTest < Test::Unit::TestCase
  fixtures  :genericworkgroups, :genericworktypes, :genericworkstatuses, :genericworks

  def setup
    @genericworks = %w(comunicaciones_tecnicas reportes_tecnicos)
    @mygenericwork = Genericwork.new({ :title => 'Comunicaciones_tecnicas _prueba', :authors => ' Andres Silva, Imelda Hernandez, Roberto Martinez_pruebas', :genericworktype_id => 5, :genericworkstatus_id => 3, :year =>  2007})
  end

  # Right - CRUD
  def test_creating_genericwork_from_yaml
    @genericworks.each { | genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_kind_of Genericwork, @genericwork
      assert_equal genericworks(genericwork.to_sym).id, @genericwork.id
      assert_equal genericworks(genericwork.to_sym).genericworktype_id, @genericwork.genericworktype_id
      assert_equal genericworks(genericwork.to_sym).genericworkstatus_id, @genericwork.genericworkstatus_id
      assert_equal genericworks(genericwork.to_sym).title, @genericwork.title
      assert_equal genericworks(genericwork.to_sym).authors, @genericwork.authors
    }
  end

  def test_updating_genericwork_id
    @genericworks.each { |genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_equal genericworks(genericwork.to_sym).id, @genericwork.id
      @genericwork.id = 4
      assert @genericwork.update
      assert_not_equal genericworks(genericwork.to_sym).id, @genericwork.id
    }
  end

    def test_updating_genericworkstatus_id
    @genericworks.each { |genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_equal genericworks(genericwork.to_sym).genericworkstatus_id, @genericwork.genericworkstatus_id
      @genericwork.genericworkstatus_id = 1
      assert @genericwork.update
      assert_not_equal genericworks(genericwork.to_sym).genericworkstatus_id, @genericwork.genericworkstatus_id
    }
  end

   def test_updating_title
    @genericworks.each { |genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_equal genericworks(genericwork.to_sym).title, @genericwork.title
      @genericwork.title = 'prueba'
      assert @genericwork.update
      assert_not_equal genericworks(genericwork.to_sym).title, @genericwork.title
    }
  end

   def test_updating_genericworktype_id
    @genericworks.each { |genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_equal genericworks(genericwork.to_sym).genericworktype_id, @genericwork.genericworktype_id
      @genericwork.genericworktype_id = 2
       assert @genericwork.update
      assert_not_equal genericworks(genericwork.to_sym).genericworktype_id, @genericwork.genericworktype_id
    }
  end

      def test_updating_authors
    @genericworks.each { |genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_equal genericworks(genericwork.to_sym).authors, @genericwork.authors
      @genericwork.authors = 'lopez'
      assert @genericwork.update
      assert_not_equal genericworks(genericwork.to_sym).authors, @genericwork.authors
    }
  end

  def test_deleting_genericworks
    @genericworks.each { |genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      @genericwork.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Genericwork.find(genericworks(genericwork.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @genericwork = Genericwork.new
    assert !@genericwork.save
  end

   def test_creating_duplicated
     @genericwork = Genericwork.new({ :title => 'Comunicaciones_tecnicas', :authors => ' Andres Silva, Imelda Hernandez, Roberto Martinez', :genericworktype_id => 5, :genericworkstatus_id => 3, :year =>  2007 })
      assert !@genericwork.save
    end

   # Boundary
   def test_bad_values_for_id
     @mygenericwork.id = 1.6
     assert !@mygenericwork.valid?
     @mygenericwork.id = 'mi_id'
     assert !@mygenericwork.valid?
   end

   def test_bad_values_for_genericwork_id
     @mygenericwork.genericworktype_id= 1.6
     assert !@mygenericwork.valid?
     @mygenericwork.genericworktype_id = 'mi_id_texto'
     assert !@mygenericwork.valid?
   end

   def test_bad_values_for_genericworkstatus_id
     @mygenericwork.genericworkstatus_id = nil
     assert !@mygenericwork.valid?
     @mygenericwork.genericworkstatus_id = 1.6
     assert !@mygenericwork.valid?
     @mygenericwork.genericworkstatus_id = 'my_year'
     assert !@mygenericwork.valid?
   end

   def test_bad_values_for_genericworkyear
     @mygenericwork.year = nil
     assert !@mygenericwork.valid?
     @mygenericwork.year = 15015.36
     assert !@mygenericwork.valid?
     @mygenericwork.year = 'my_year'
     assert !@mygenericwork.valid?
   end


  #cross-Checking test for genericwork
  def test_cross_checking_for_genericworktype_id
    @genericworks.each { | genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_kind_of Genericwork, @genericwork
      assert_equal @genericwork.genericworktype_id, Genericworktype.find(@genericwork.genericworktype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_genericworktype_id
    @genericworks.each { | genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_kind_of Genericwork, @genericwork
      @genericwork.genericworktype_id = 5
          begin
        return true if @genericwork.update
           rescue StandardError => x
        return false
      end
    }
  end

  #cross check for edition
  def test_cross_checking_for_genericworkstatus_id
    @genericworks.each { | genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_kind_of Genericwork, @genericwork
      assert_equal @genericwork.genericworkstatus_id, Genericworkstatus.find(@genericwork.genericworkstatus_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_genericworkstatus_id
    @genericworks.each { | genericwork|
      @genericwork = Genericwork.find(genericworks(genericwork.to_sym).id)
      assert_kind_of Genericwork, @genericwork
      @genericwork.genericworkstatus_id = 10
       begin
        return true if @genericwork.update
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

end
