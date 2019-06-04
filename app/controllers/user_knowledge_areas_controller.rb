class UserKnowledgeAreasController < UserResourcesController
  def create
    if User.find(current_user.id).my_knowledge_areas.count==6 then
      redirect_to new_user_knowledge_area_path(params), :notice => "No está permitido tener más de 6 áreas de conocimiento / laboratorios nacionales o universitarios / proyectos en experimentos internacionales"
      return(current_user.id.to_s)
    end
    build_resource.user_id = current_user.id
    build_resource.registered_by_id = current_user.id
    create! { collection_url }
  end
end
