class ThesisExaminationsController < PublicationController
   defaults :user_role_class => :thesis_jurors, :role_class => :roleinjury, :user_role_columns => [:year]
end
