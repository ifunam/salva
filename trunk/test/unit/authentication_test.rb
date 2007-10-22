require File.dirname(__FILE__) + '/../test_helper'
require  RAILS_ROOT + '/lib/authentication'


class TestAuthentication < Test::Unit::TestCase
  include Authentication
  fixtures  :userstatuses, :users
  def setup
    @default_users = %w( admin juana panchito )
  end

  def test_authenticate_by_token_eh
 #right
    for user in (@default_users)
      busc= User.find_by_login(user)
      assert_equal true, authenticate_by_token?(busc,busc.token)
      busc= User.find_by_login(user)
      assert_equal nil, busc.token
    end

# Testing arguments
    assert_raises (ArgumentError) { authenticate_by_token?() }
    assert_raises (ArgumentError) { authenticate_by_token?('token1') }
    assert_raises (ArgumentError) { authenticate_by_token?('juana') }

#bad_values
     assert !authenticate_by_token?(nil,nil)
#  assert !authenticate_by_token?(2,nil)
     assert !authenticate_by_token?(nil,'wkbg')
  end
  def test_authenticate_eh
    #right
    for user in (@default_users)
      assert_equal true,  authenticate?(user, 'maltiempo')
    end

    #testing arguments
    assert_raises (ArgumentError) { authenticate?( ) }
    assert_raises (ArgumentError) { authenticate?(user ) }
    assert_raises (ArgumentError) { authenticate?( 'maltiempo') }

     #bad values
     assert !authenticate?(nil,nil)
     assert !authenticate?(2,nil)
     assert !authenticate?(nil,'wkbg')

    end

  def test_authenticate_login_exist
   #Right
    for user in (@default_users)
      assert_equal true, (self.send :login_exists?, user)
    end
    #arguments
    assert_equal false, (self.send :login_exists?, nil)
    assert_equal false, (self.send :login_exists?,  'chente_fox')
    assert_equal false, (self.send :login_exists?,  5)
  end
end


