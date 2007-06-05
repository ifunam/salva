require File.dirname(__FILE__) + '/../test_helper'
require 'instadvicetarget'

class InstadvicetargetTest < Test::Unit::TestCase
  fixtures :instadvicetargets
  def setup
    @instadvicetargets = %w(material_didactico proyecto_de_investigacion planes_o_programas_de_estudio)
    @myinstadvicetarget = Instadvicetarget.new({:name => 'Evaluacion'})
  end
  
  # Right - CRUD
  def test_creating_from_yaml
    @instadvicetargets.each { |instadvicetarget|
      @instadvicetarget = Instadvicetarget.find(instadvicetargets(instadvicetarget.to_sym).id)
      assert_kind_of Instadvicetarget, @instadvicetarget
      assert_equal instadvicetargets(instadvicetarget.to_sym).id, @instadvicetarget.id
      assert_equal instadvicetargets(instadvicetarget.to_sym).name, @instadvicetarget.name
    }
  end
  
  def test_updating_name
    @instadvicetargets.each { |instadvicetarget|
      @instadvicetarget = Instadvicetarget.find(instadvicetargets(instadvicetarget.to_sym).id)
      assert_equal instadvicetargets(instadvicetarget.to_sym).name, @instadvicetarget.name
      @instadvicetarget.name = @instadvicetarget.name.chars.reverse 
      assert @instadvicetarget.update
      assert_not_equal instadvicetargets(instadvicetarget.to_sym).name, @instadvicetarget.name
    }
  end  

  def test_deleting
    @instadvicetargets.each { |instadvicetarget|
      @instadvicetarget = Instadvicetarget.find(instadvicetargets(instadvicetarget.to_sym).id)
      @instadvicetarget.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Instadvicetarget.find(instadvicetargets(instadvicetarget.to_sym).id)
      }
    }
  end

  def test_uniqueness
    @instadvicetarget = Instadvicetarget.new({:name => 'Planes o programas de estudio'})
    assert !@instadvicetarget.save
  end

  def test_empty_object
    @instadvicetarget = Instadvicetarget.new()
    assert !@instadvicetarget.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myinstadvicetarget.id = 'xx'
    assert !@myinstadvicetarget.valid?

    # Negative number ID 
    # @myinstadvicetarget.id = -1
    # assert !@myinstadvicetarget.valid?

    # Float number ID 
    @myinstadvicetarget.id = 1.3
    assert !@myinstadvicetarget.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myinstadvicetarget = Instadvicetarget.new
    @myinstadvicetarget.name = nil
    assert !@myinstadvicetarget.valid?

    @myinstadvicetarget.name = 'mytext' * 80
    assert !@myinstadvicetarget.valid?

    @myinstadvicetarget.name = 'm'
    assert !@myinstadvicetarget.valid?

  end
end
