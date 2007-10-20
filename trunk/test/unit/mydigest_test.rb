require File.dirname(__FILE__) + '/../test_helper'
require  RAILS_ROOT + '/lib/mydigest'


class TestMydigest < Test::Unit::TestCase
  include Mydigest

  def test_encrypt
   salt = salted
   # Testing arguments
    assert_raises (ArgumentError) { encrypt() }
    assert_raises (ArgumentError) { encrypt('mvac') }
    assert_raises (NoMethodError) { encrypt(nil,salted) }
    assert_raises (NoMethodError) { encrypt(nil,nil) }

    # Right
    assert 128, encrypt('asdfgddddasd', salted).length
    assert_equal encrypt('mvac', salt), encrypt('mvac', salt)
    assert_not_equal encrypt('mvacs', salt), encrypt('mvac', salt)
    assert_not_equal encrypt('mvac', salt), encrypt('mvac', salted)
  end

  def test_salted
    # Testing arguments
    assert_raises (ArgumentError) { salted(5) }
    assert_raises (ArgumentError) { salted(5,10) }
    assert_raises (ArgumentError) { salted(nil) }

    # Right
    assert 40,  salted.length
    assert salted
    assert_not_nil salted
    salt = salted
    assert_not_equal  salt, salted
  end

  def test_token_string
    valid_alphabet = (('a'..'z').collect + ('A'..'Z').collect + ('0'..'9').collect + ['.','/']).join('')

    # Assertions for valid chars
    assert true, (token_string(10) + ' '  =~ /^[#{valid_alphabet}]/)
    assert 0, (token_string(10)  =~ /^[#{valid_alphabet}]/)

    # Testing arguments
    assert_raises(ArgumentError) { token_string() }
    assert_raises(ArgumentError) { token_string(5, 4) }

    # Right
    assert 10, token_string(10).length
    assert_nil token_string(-1)
    assert_nil token_string(0)
    assert_nil token_string(0.999)
    assert 1, token_string(1.49)
  end
end
