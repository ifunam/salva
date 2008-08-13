require File.dirname(__FILE__) + '/../test_helper'
require  RAILS_ROOT + '/lib/authentication'


class TestAuthentication < Test::Unit::TestCase
  include Authentication
  fixtures  :userstatuses, :users
  def setup
    @default_users = %w( admin juana panchito )
  end

  def test_authenticate_by_token
    # Testing arguments
    assert_raises (ArgumentError) { authenticate_by_token?() }
    assert_raises (ArgumentError) { authenticate_by_token?('token1') }
    assert_raises (ArgumentError) { authenticate_by_token?('juana') }

    # Right behaviour
    for login in (@default_users)
      @user = User.find_by_login(login)
      assert_equal true, authenticate_by_token?(@user.id,@user.token)
      assert_equal nil, @user.token
    end

    # Bad values
    assert !authenticate_by_token?(nil,nil)
    assert !authenticate_by_token?(nil,'wkbg')
    #  assert !authenticate_by_token?(2,nil)
  end
  
  def test_authenticate
    # Testing arguments
    assert_raises (ArgumentError) { authenticate?() }
    assert_raises (ArgumentError) { authenticate?('juana') }
    assert_raises (ArgumentError) { authenticate?('maltiempo') }
    
    # Right behaviour
    for login in (@default_users)
      assert_equal true,  authenticate?(login, 'maltiempo')
    end

     # Bad values
     assert !authenticate?(nil,nil)
     assert !authenticate?(2,nil)
     assert !authenticate?(nil,'wkbg')
  end

  def test_authenticate_login_exist
    # Right behaviour
    for login in (@default_users)
      assert_equal true, (self.send :login_exists?, login)
    end
    
    # Testing with bad arguments
    assert_equal false, (self.send :login_exists?, nil)
    assert_equal false, (self.send :login_exists?, 'elpinche_chente_fox')
    assert_equal false, (self.send :login_exists?, 5)
  end
end


