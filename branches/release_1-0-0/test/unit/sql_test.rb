require File.dirname(__FILE__) + '/../test_helper'
require RAILS_ROOT + '/lib/sql'

class TestSql < Test::Unit::TestCase
  include Sql

  def test_set_conditions
    # Error Arguments
    assert_raises (ArgumentError) { set_conditions}
    assert_raises (ArgumentError) { set_conditions('a','b','c') }

    # Right
    assert_instance_of Array, set_conditions(['firstname','lastname1'],['Juana','Maltiempo'])
    assert_equal ["firstname = ?  AND lastname1 = ? ", "Juana", "Maltiempo"], set_conditions(['firstname','lastname1'],['Juana','Maltiempo'])

    # Bad Values
    assert_raises (TypeError) { set_conditions([2,'lastname1'],['Juana','Maltiempo'])}
  end

  def test_set_conditions_by_ids_and_like_with_hash
    # Error Arguments
    assert_raises (ArgumentError) { set_conditions_by_ids_and_like}
    assert_raises (ArgumentError) { set_conditions_by_ids_and_like('a','b','c') }

    # Right
    assert_instance_of Array, set_conditions_by_ids_and_like({'firstname' => 'Juana', 'lastname1' => 'Maltiempo'})
    assert_equal ["lastname1 LIKE ? AND firstname LIKE ?", "Maltiempo", "Juana"] ,set_conditions_by_ids_and_like({'firstname' => 'Juana', 'lastname1' => 'Maltiempo'})

    # Bad Values
    #assert_raises (NoMethodError), set_conditions_by_ids_and_like(1)
  end

  def test_sql_conditions_by_ids_and_like_with_keys
    # Error Arguments
    assert_raises (ArgumentError) { sql_conditions_by_ids_and_like}
    assert_raises (ArgumentError) { sql_conditions_by_ids_and_like('a','b','c') }

    # Right
    assert_instance_of String, sql_conditions_by_ids_and_like(['firstname','lastname1'])
    assert_equal 'firstname LIKE ? AND lastname1 LIKE ?', sql_conditions_by_ids_and_like(['firstname','lastname1'])

    # Bad Values
    # assert_raises (NoMethodError), sql_conditions_by_ids_and_like(1)
  end

  def test_sql_conditions_from_keys
    # Error Arguments
    assert_raises (ArgumentError) { sql_conditions_from_keys}
    assert_raises (ArgumentError) { sql_conditions_from_keys('a','b','c') }

    # Right
    assert_instance_of String, sql_conditions_from_keys(['firstname','lastname1'])
    assert_equal "firstname = ?  AND lastname1 = ? ", sql_conditions_from_keys(['firstname','lastname1'])

    # Bad Values
    assert_raises (TypeError) { sql_conditions_from_keys([2,'lastname1'])}
  end
end
