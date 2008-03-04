require File.dirname(__FILE__) + '/../test_helper'
require 'editionstatus'

class EditionstatusTest < Test::Unit::TestCase
  fixtures :editionstatuses
  include UnitSimple
  def setup
    @editionstatuses = %w(publicado en_prensa aceptado_para_publicacion)
    @myeditionstatus = Editionstatus.new({:name => 'En edición'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@editionstatuses, Editionstatus)
  end

  def test_validation
    validate_test(@editionstatuses, Editionstatus)
  end

  def test_collision
    collision_test(@editionstatuses, Editionstatus)
  end

  def test_uniqueness
    @editionstatus = Editionstatus.new({:name => 'Aceptado para publicación'})
    assert !@editionstatus.save
  end

  def test_empty_object
    @editionstatus = Editionstatus.new()
    assert !@editionstatus.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myeditionstatus.id = 'xx'
    assert !@myeditionstatus.valid?

    # Negative number ID
    # @myeditionstatus.id = -1
    # assert !@myeditionstatus.valid?

    # Float number ID
    @myeditionstatus.id = 1.3
    assert !@myeditionstatus.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myeditionstatus = Editionstatus.new
    @myeditionstatus.name = nil
    assert !@myeditionstatus.valid?
  end
end
