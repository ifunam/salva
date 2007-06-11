require File.dirname(__FILE__) + '/../test_helper'
require 'genericworkgroup'
class GenericworkgroupTest < Test::Unit::TestCase
  fixtures :genericworkgroups
  include UnitSimple

  def setup
    @genericworkgroups = %w(publicaciones productos_de_divulgacion)
    @mygenericworkgroup = Genericworkgroup.new({:name => 'Otro', :id => 5})
  end

  # Right - CRUD
  def test_crud
      crud_test(@genericworkgroups, Genericworkgroup)
  end

  def test_validation
     validate_test(@genericworkgroups, Genericworkgroup)
  end

  def test_collision
     collision_test(@genericworkgroups, Genericworkgroup)
  end

  def test_creating_with_empty_attributes
    @genericworkgroup = Genericworkgroup.new
    assert !@genericworkgroup.save
  end

  def test_uniqueness
    @genericworkgroup = Genericworkgroup.new({:name => 'Publicaciones', :id => 3})
    @genericworkgroup.id = 3
    assert !@genericworkgroup.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mygenericworkgroup.id = 1.6
    assert !@mygenericworkgroup.valid?

    # Negative numbers
    # @mygenericworkgroup.id = -1
    # assert !@mygenericworkgroup.valid?
  end

  def test_bad_values_for_name
    @mygenericworkgroup.name = nil
    assert !@mygenericworkgroup.valid?

    @mygenericworkgroup.name = 'A'
    assert !@mygenericworkgroup.valid?

    @mygenericworkgroup.name = 'AB' * 800
    assert !@mygenericworkgroup.valid?
  end
end
