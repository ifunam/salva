# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.
    #
    # primary.item :key_1, 'name', url, options

    # Add an item which has a sub navigation (same params, but with block)
    # primary.item :key_2, 'name', url, options do |sub_nav|
      # Add an item to the sub navigation (same params again)
      # sub_nav.item :key_2_1, 'name', url, options
    # end

    primary.item :profile, 'Perfil', user_profile_path, :highlights_on => /^\/$/ do |s|
      s.item :user_profile, 'Información general', user_profile_path, :highlights_on => /\/user_profile/
      s.item :jobpositions, 'Categorías', jobpositions_path, :highlights_on => /\/jobpositions/
      s.item :jobposition_log, :'Antigüedad en la UNAM', jobposition_log_path, :highlights_on => /\/jobposition_log/
      s.item :educations, 'Escolaridad', educations_path, :highlights_on => /\/educations/
      s.item :projects, 'Proyectos', projects_path, :highlights_on => /\/projects/
      s.item :user_stimuli, 'Estímulos académicos', user_stimuli_path, :highlights_on => /\/user_stimuli/
      s.item :course_attendees, 'Cursos recibidos', course_attendees_path, :highlights_on => /\/course_attendees/
      s.item :conference_attendees, 'Asistencia a eventos académicos', conference_attendees_path, :highlights_on => /\/conference_attendees/
      s.item :user_schoolarships, 'Becas', user_schoolarships_path, :highlights_on => /\/user_schoolarships/
      s.item :memberships, 'Membresias en asociaciones académicas', memberships_path, :highlights_on => /\memberships/
      s.item :user_prizes, 'Premios recibidos', user_prizes_path, :highlights_on => /\/user_prizes/
      s.item :user_credits, 'Agradecimientos y otros créditos', user_credits_path, :highlights_on => /\/user_credits/
      s.item :institutional_activities, 'Participación institucional', institutional_activities_path, :highlights_on => /\/institutional_activities/
      s.item :user_languages, 'Idiomas', user_languages_path, :highlights_on => /\/user_languages/
      s.item :user_skills, 'Técnicas experimentales y habilidades', user_skills_path, :highlights_on => /\/user_skills/
      s.item :user_settings, 'Página web', user_settings_path, :highlights_on => /\/user_settings/
      s.item :password, 'Cambiar password', edit_password_path, :highlights_on => /\/password/
    end

    primary.item :publications, 'Publicaciones', articles_path do |s|
      s.item :articles, 'Artículos publicados', articles_path, :highlights_on => /\/articles/
      s.item :unpublished_articles, 'Artículos enviados o aceptados', unpublished_articles_path, :highlights_on => /\/unpublished_articles/
      s.item :book_authors, 'Autoría de libros', book_authors_path, :highlights_on => /\/book_authors/
      s.item :book_chapters, 'Capítulos en libros', book_chapters_path, :highlights_on => /\/book_chapters/
      s.item :technical_reports, 'Reportes técnicos', technical_reports_path, :highlights_on => /\/technical_reports/
      s.item :reviews, 'Reseñas', reviews_path, :highlights_on => /\/reviews/
    end

    primary.item :seminary_and_conferences, 'Congresos', seminaries_path do |s|
      s.item :seminaries, 'Seminarios y conferencias', seminaries_path, :highlights_on => /\/seminaries/
      s.item :conference_organizers, 'Comités de congresos', conference_organizers_path, :highlights_on => /\/conference_organizers/
      s.item :conference_talks, 'Trabajos presentados en congresos', conference_talks_path, :highlights_on => /\/conference_talks/
    end

    primary.item :refereed_colaborations, 'Colaboración en publicaciones', user_journals_path do |s|
      s.item :user_journals, 'Colaboración en publicaciones', user_journals_path, :highlights_on => /\/user_journals/
      s.item :user_refereed_journals, 'Arbitraje en revistas', user_refereed_journals_path, :highlights_on => /\/user_refereed_journals/
      s.item :book_collaborations, 'Colaboración en libros', book_collaborations_path, :highlights_on => /\/book_collaborations/
    end

    primary.item :popular_science, 'Divulgación', newspaper_articles_path do |s|
      s.item :newspaper_articles, 'Artículos periodísticos', newspaper_articles_path, :highlights_on => /\/newspaper_articles/
      s.item :popular_science_works, 'Trabajos de divulgación', popular_science_works_path, :highlights_on => /\/popular_science_works/
    end

    primary.item :outreach_activities, 'Vinculación', professor_advices_path do |s|
      s.item :professor_advices, 'Asesoría de personal académico', professor_advices_path, :highlights_on => /\/professor_advices/
      s.item :institutional_advices, 'Asesoría a instituciones', institutional_advices_path, :highlights_on => /\/institutional_advices/
      s.item :outreach_works, 'Trabajos de vinculación', outreach_works_path, :highlights_on => /\/outreach_works/
    end

    primary.item :teaching, 'Docencia', regular_courses_path do |s|
      s.item :regular_courses, 'Cursos regulares', regular_courses_path, :highlights_on => /\/regular_courses/
      s.item :course_instructors, 'Cursos especiales', course_instructors_path, :highlights_on => /\/course_instructors/
      s.item :theses, 'Dirección de tesis', theses_path, :highlights_on => /\/theses/
      s.item :thesis_examinations, 'Jurado de tesis', thesis_examinations_path, :highlights_on => /\/thesis_examinations/
      s.item :tutorial_committees, 'Comités tutorales', tutorial_committees_path, :highlights_on => /\/tutorial_committees/
      s.item :student_advices, 'Asesoría a estudiantes', student_advices_path, :highlights_on => /\/student_advices/
      s.item :other_teaching_activities, 'Actividades de docencia', other_teaching_activities_path, :highlights_on => /\/other_teaching_activities/
      s.item :teaching_products, 'Productos de docencia', teaching_products_path, :highlights_on => /\/teaching_products/
    end

    primary.item :tech_activities, 'Actividades técnico - académicas', technical_activities_path do |s|
      s.item :technical_activities, 'Actividades técnicas', technical_activities_path, :highlights_on => /\/technical_activities/
      s.item :technical_products, 'Productos técnicos', technical_products_path, :highlights_on => /\/technical_products/
    end

    primary.item :others, 'Otros', other_activities_path do |s|
      s.item :other_activities, 'Otras actividades', other_activities_path, :highlights_on => /\/other_activities/
      s.item :other_works, 'Otros productos', other_works_path, :highlights_on => /\/other_works/
    end

    primary.item :reports, 'Informes', user_annual_reports_path do |s|
      s.item :user_annual_reports, 'Informe anual', user_annual_reports_path, :highlights_on => /\/user_annual_reports/
      s.item :user_annual_plans, 'Plan anual', user_annual_plans_path, :highlights_on => /\/user_annual_plans/
   end

    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    # primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    # primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end
