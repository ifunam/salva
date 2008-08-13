require File.dirname(__FILE__) + '/../test_helper'
require 'articlestatus'

class ArticlestatusTest < Test::Unit::TestCase
  fixtures :articlestatuses
  include UnitSimple
  def setup
    @articlestatuses = %w(en_prensa aceptado enviado)
    @myarticlestatus = Articlestatus.new({:name => 'En proceso'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@articlestatuses, Articlestatus)
  end

  def test_validation
    validate_test(@articlestatuses, Articlestatus)
  end

  def test_collision
    collision_test(@articlestatuses, Articlestatus)
  end

  def test_uniqueness
    @articlestatus = Articlestatus.new({:name => 'En prensa'})
    assert !@articlestatus.save
  end

  def test_empty_object
    @articlestatus = Articlestatus.new()
    assert !@articlestatus.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myarticlestatus.id = 'xx'
    assert !@myarticlestatus.valid?

    # Negative number ID
    #@myarticlestatus.id = -1
    #assert !@myarticlestatus.valid?

    # Float number ID
    @myarticlestatus.id = 1.3
    assert !@myarticlestatus.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myarticlestatus = Articlestatus.new
    @myarticlestatus.name = nil
    assert !@myarticlestatus.valid?
  end
end
