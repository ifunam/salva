class UserObserver < ActiveRecord::Observer
  observe User
  
  def before_save(user)
    @new = user.new_record?
  end
  
  def after_save(user)
    if @new
      @usersgroups= UsersGroups.new
      @usersgroups.user_id = user.id
      @usersgroups.group_id = 2 # Salva group
      @usersgroups.save
    end
  end
end
