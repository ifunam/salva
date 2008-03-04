require File.dirname(__FILE__) + '/../test_helper'
require RAILS_ROOT + '/lib/labels'
class TestLabels < Test::Unit::TestCase
  include Labels
  def test_get_label
    # Error Arguments
    assert_raises (ArgumentError) { get_label }
    assert_raises (ArgumentError) { get_label('a', 'b') }

    # Right
    assert_equal "Sí", get_label('yes')
    assert_equal "No", get_label('no')

    # Undefined label
    assert_equal "unexistent no esta definido en #{RAILS_ROOT}/po/salva.yml", get_label('unexistent')
  end

  def test_label_for_boolean
    # Error arguments
    assert_raises (ArgumentError) { label_for_boolean }
    assert_raises (ArgumentError) { label_for_boolean('gender') }
    assert_raises (ArgumentError) { label_for_boolean(true) }
    assert_raises (ArgumentError) { label_for_boolean('gender', true, 'extra_argument') }

    # Right params
    assert_equal "Masculino", label_for_boolean('gender', true)
    assert_equal "Femenino", label_for_boolean('gender', false)
    assert_equal "Grado en curso", label_for_boolean('is_studying_this', true)
    assert_equal "Grado terminado", label_for_boolean('is_studying_this', false)
    assert_equal "Con privilegios de grupo", label_for_boolean('has_group_right', true)
    assert_equal "Sin privilegios", label_for_boolean('has_group_right', false)
    assert_equal "Autor principal", label_for_boolean('ismainauthor', true)
    assert_equal "Coautor", label_for_boolean('ismainauthor', false)
    assert_equal "Seminario", label_for_boolean('isseminary', true)
    assert_equal "Conferencia", label_for_boolean('isseminary', false)
    assert_equal "Sí", label_for_boolean('is_postaddress', true)
    assert_equal "No", label_for_boolean('is_postaddress', false)
  end
end

# Number of errors detected: 3
