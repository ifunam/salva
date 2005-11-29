class UserObserver < ActiveRecord::Observer
  observe User
  
  def before_save(user)
    @new = user.new_record?
  end
  
  def after_save(user)
    if @new
      @usergroup= UserGroup.new
      @usergroup.user_id = user.id
      @usergroup.group_id = 2 # Salva group
      @usergroup.save
    end
  end
end
