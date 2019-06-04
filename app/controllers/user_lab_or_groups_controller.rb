class UserLabOrGroupsController < UserResourcesController
  def create
    if User.find(current_user.id).my_lab_or_groups.count==5 then
      redirect_to new_user_lab_or_group_path(params), :notice => "No está permitido tener más de 5 laboratorios ó grupos"
      return(current_user.id.to_s)
    end
    build_resource.user_id = current_user.id
    build_resource.registered_by_id = current_user.id
    create! { collection_url }
  end
end
