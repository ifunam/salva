require File.dirname(__FILE__) + '/../test_helper'
require 'jobpositiontype'

class JobpositiontypeTest < Test::Unit::TestCase
  fixtures :jobpositiontypes
  include UnitSimple
  def setup
    @jobpositiontypes = %w(personal_academico_para_docencia personal_administrativo_de_confianza personal_academico_para_investigacion)
    @myjobpositiontype = Jobpositiontype.new({:name => 'Personal administrativo de base'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@jobpositiontypes, Jobpositiontype)
  end

  def test_validation
    validate_test(@jobpositiontypes, Jobpositiontype)
  end

  def test_collision
    collision_test(@jobpositiontypes, Jobpositiontype)
  end

  def test_uniqueness
    @jobpositiontype = Jobpositiontype.new({:name => 'Personal académico para investigación'})
    assert !@jobpositiontype.save
  end

  def test_empty_object
    @jobpositiontype = Jobpositiontype.new()
    assert !@jobpositiontype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myjobpositiontype.id = 'xx'
    assert !@myjobpositiontype.valid?

    # Negative number ID
    #@myjobpositiontype.id = -1
    #assert !@myjobpositiontype.valid?

    # Float number ID
    @myjobpositiontype.id = 1.3
    assert !@myjobpositiontype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myjobpositiontype = Jobpositiontype.new
    @myjobpositiontype.name = nil
    assert !@myjobpositiontype.valid?
  end
end
