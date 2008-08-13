module UserHelper
  def get_user(id,attr=nil)
    attr = 'login' if attr == nil
    user = User.find(id)
    user[attr]
  end
  
  def logged_user
    if session[:user]
      get_user(session[:user])
    end
  end

  def db_moduser(id=nil)
    if id 
      get_user(id)
    else
      'S A L V A'
    end
  end
end
