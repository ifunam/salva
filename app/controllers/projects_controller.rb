class ProjectsController < PublicationController
  defaults :user_role_class => :user_projects, :role_class => :roleinproject
end