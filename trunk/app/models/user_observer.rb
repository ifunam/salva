class UserObserver < ActiveRecord::Observer
  observe User
  
  def before_save(user)
    @new = user.new_record?
  end

#  Useroleingroup.new({:user_id => @user.id, :roleingroup_id => }
                           
  #   def after_save(user)
  #     if @new
  #       @usergroup= UserRoleingroup.new
  #       @usergroup.user_id = user.id
  #       @usergroup.group_id = 2 # Salva group
  #       @usergroup.save
  #     end
  #   end
end
