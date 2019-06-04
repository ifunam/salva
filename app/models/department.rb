class Department < User
  #Department Heads -- Jefes de departamento

  def self.departments(user)
    if user.admin? then
      Adscription.enabled.all
    elsif user.head?
      [DepartmentHead.where(:user_id=>user.id).first.adscription]
    else
      []
    end
  end

end
