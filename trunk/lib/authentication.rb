require 'mydigest'
module Authentication
  include Mydigest

  def authenticate?(login,passwd)
    if login_exists?(login)
      @user = User.find_by_login(login)
      return true if @user.passwd == encrypt(passwd, @user.salt) and @user.is_activated?
    end
    return false
  end

  def authenticate_by_token?(id,token)
    @user = User.find_by_id_and_token(id,token)
    unless @user.nil?
      @user.destroy_token
      return true
    end
    return false
  end

  private
  def login_exists?(login)
    re turn true unless User.find_by_login(login).nil?
    return false
  end
end
