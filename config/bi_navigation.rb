SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :verified_articles, 'Publicaciones/depto', bi_verified_articles_path  do |sub_nav|
      sub_nav.item :verified_articles, 'Sin repetidos', bi_verified_articles_path
      sub_nav.item :repeated_verified_articles, 'Con repetidos', bi_verified_articles_path+'?t=repeated'
      sub_nav.item :journal_verified_articles, 'Nacional / Internacional', bi_verified_articles_path+'?t=journal'
    end
    primary.item :impact_factors, 'Publicaciones/FI', bi_impact_factors_path
    primary.item :academics, 'Acad/depto', bi_researcher_adscriptions_path do |sub_nav|
      sub_nav.item :researchers, 'Investigadores', bi_researcher_adscriptions_path
      sub_nav.item :technicians, 'Técnicos académicos', bi_researcher_adscriptions_path+'?t=technician'
      sub_nav.item :posdocs, 'Posdoctorales', bi_researcher_adscriptions_path+'?t=posdoc'
    end
    primary.item :categories, 'Acad/categoría', bi_researcher_categories_path do |sub_nav|
      sub_nav.item :researchers, 'Investigadores', bi_researcher_categories_path
      sub_nav.item :technicians, 'Técnicos académicos', bi_researcher_categories_path+'?t=technician'
    end
    primary.item :academics, 'Acad/edades', bi_researcher_ages_path do |sub_nav|
      sub_nav.item :researchers, 'Investigadores', bi_researcher_ages_path
      sub_nav.item :technicians, 'Técnicos académicos', bi_researcher_ages_path+'?t=technician'
      sub_nav.item :posdocs, 'Posdoctorales', bi_researcher_ages_path+'?t=posdoc'
    end
    primary.item :knowledge_fields, 'Acad/campos', bi_knowledge_fields_path do |sub_nav|
      sub_nav.item :researchers, 'Investigadores', bi_knowledge_fields_path
      sub_nav.item :technicians, 'Técnicos académicos', bi_knowledge_fields_path+'?t=technician'
      sub_nav.item :posdocs, 'Posdoctorales', bi_knowledge_fields_path+'?t=posdoc'
    end
    # primary.item :knowledge_areas, 'Áreas', bi_knowledge_areas_path do |sub_nav|
    #   sub_nav.item :researchers, 'Investigadores', bi_knowledge_areas_path
    #   sub_nav.item :technicians, 'Técnicos académicos', bi_knowledge_areas_path+'?t=technician'
    #   sub_nav.item :posdocs, 'Posdoctorales', bi_knowledge_areas_path+'?t=posdoc'
    # end
    primary.item :theses, 'Tesis', bi_theses_path
    primary.item :courses, 'Cursos', bi_regular_courses_path
    primary.item :proceedings, 'Memorias', bi_refereed_proceedings_path do |sub_nav|
      sub_nav.item :refereed, 'Arbitradas', bi_refereed_proceedings_path
      sub_nav.item :unrefereed, 'In Extenso', bi_unrefereed_proceedings_path
    end
    primary.item :books, 'Libros', bi_books_path do |sub_nav|
      sub_nav.item :authors, 'Autoría', bi_books_path
      sub_nav.item :chapters, 'Capítulos', bi_books_path+'?t=chapters'
    end
    primary.item :students, 'Estudiantes', bi_students_path do |sub_nav|
      sub_nav.item :per_year, 'por año', bi_students_path
      sub_nav.item :per_period, 'por semestre', bi_students_path+'?t=sem'
      sub_nav.item :per_adscription, 'por adscripción', bi_students_path+'?t=adsc'
    end
  end
end
