require File.dirname(__FILE__) + '/../test_helper'
require 'thesismodality'

class ThesismodalitylTest < Test::Unit::TestCase
  fixtures :thesismodalities
  def setup
    @thesismodalities = %w(tesis tesina)
    @mythesismodality = Thesismodality.new({:name => 'Reporte'})
  end

  # Right - CRUD
  def test_creating_from_yaml
    @thesismodalities.each { | thesismodality|
      @thesismodality = Thesismodality.find(thesismodalities(thesismodality.to_sym).id)
      assert_kind_of Thesismodality, @thesismodality
      assert_equal thesismodalities(thesismodality.to_sym).id, @thesismodality.id
      assert_equal thesismodalities(thesismodality.to_sym).name, @thesismodality.name
    }
  end

  def test_updating_name
    @thesismodalities.each { |thesismodality|
      @thesismodality = Thesismodality.find(thesismodalities(thesismodality.to_sym).id)
      assert_equal thesismodalities(thesismodality.to_sym).name, @thesismodality.name
      @thesismodality.name = @thesismodality.name.chars.reverse
      assert @thesismodality.update
      assert_not_equal thesismodalities(thesismodality.to_sym).name, @thesismodality.name
    }
  end 

  def test_deleting
    @thesismodalities.each { |thesismodality|
      @thesismodality = Thesismodality.find(thesismodalities(thesismodality.to_sym).id)
      @thesismodality.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Thesismodality.find(thesismodalities(thesismodality.to_sym).id)
      }
    }
  end

  def test_uniqueness
    @thesismodality = Thesismodality.new({:name => 'Tesina'})
    assert !@thesismodality.save
  end

  def test_empty_object
    @thesismodality = Thesismodality.new()
    assert !@thesismodality.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mythesismodality.id = 'xx'
    assert !@mythesismodality.valid?

    # Negative number ID
    #@mythesismodality.id = -1
    #assert !@mythesismodality.valid?

    # Float number ID
    @mythesismodality.id = 1.3
    assert !@mythesismodality.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mythesismodality = Thesismodality.new
    @mythesismodality.name = nil
    assert !@mythesismodality.valid?
  end
end
