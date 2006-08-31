require File.dirname(__FILE__) + '/../test_helper'
require RAILS_ROOT + '/lib/digest'
class UserTest < Test::Unit::TestCase
  fixtures :userstatuses, :users
  include Digest

  def setup
    @default_users = %w( admin juana panchito )
    @default_userstatus = ['Activo', 'Bloqueado', 'Archivo muerto']
    @attributes = %w( login passwd email userstatus_id )
    #    @admin = User.find_by_login('admin')
    #    @juana = User.find_by_login('juana')
    #    @panchito = 
  end

  def test_new_userstatus
    userstatus = Userstatus.find_by_name('Nuevo')
    for login in (@default_users)
      user = User.find_by_login(login)
      assert_equal userstatus.id, user.userstatus_id
    end
  end
  
  def test_change_userstatus
    # Testing the change of the userstatus from Nuevo to @default_userstatus
    for status in (@default_userstatus)
      userstatus = Userstatus.find_by_name(status)
      for login in (@default_users)
        user = User.find_by_login(login)
        user.userstatus_id = userstatus.id
        assert user.save
        assert_equal userstatus.id, user.userstatus_id
      end
    end
  end
  
  def test_bad_values
    for user in (@default_users)
      @user = User.find_by_login(user)
      # Checking for invalid email addresses
      @user.email = token_string(300)
      assert !@user.save
      assert @user.errors.invalid?('email')
      
      # Checking for not null logins
      @user.login = nil
      assert !@user.save
      assert_not_nil @user.errors.count
      # Checking for not null password
      @user.passwd = nil
      assert !@user.save
      assert_not_nil @user.errors.count
    end
  end
  
  def test_collision
    for user in (@default_users)
      @u =  users(user.to_sym)
      @user = User.new
      for attr in (@attributes)
        @user.[]=(attr, @u.send(attr))
      end
      assert !@user.save
    end
  end

  def test_create
    @user = User.new
    @user.login = 'tomas'
    @user.email = 'tomas@lachingada.com'
    @user.passwd = 'Wr0n3ncryp710n'
    @user.userstatus_id = Userstatus.find_by_name('Nuevo').id
    assert @user.save
  end
end
