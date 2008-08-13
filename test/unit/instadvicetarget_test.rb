require File.dirname(__FILE__) + '/../test_helper'
require 'instadvicetarget'

class InstadvicetargetTest < Test::Unit::TestCase
  fixtures :instadvicetargets
  include UnitSimple

  def setup
    @instadvicetargets = %w(material_didactico proyecto_de_investigacion planes_o_programas_de_estudio)
    @myinstadvicetarget = Instadvicetarget.new({:name => 'Evaluacion'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@instadvicetargets, Instadvicetarget)
  end

  def test_validation
    validate_test(@instadvicetargets, Instadvicetarget)
  end

  def test_collision
    collision_test(@instadvicetargets, Instadvicetarget)
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
  end
end
