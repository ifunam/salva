# encoding: utf-8
ActiveAdmin.register UserRegularcourse, :as => 'RegularCourse' do
  menu :parent => 'Docencia', :label => 'Cursos regulares'

  index :title => 'Cursos regulares' do
    column(:id) { |record| record.regularcourse.id }
    column(:title) { |record| record.regularcourse.title }
    column(:degree) { |record| record.regularcourse.academicprogram.career.degree.name }
    column(:career) { |record| record.regularcourse.academicprogram.career.name }
    column(:academicprogram_type) { |record| record.regularcourse.academicprogram.academicprogramtype.name }
    column(:faculty) { |record| record.regularcourse.academicprogram.career.institution.name}
    column(:institution) { |record| record.regularcourse.academicprogram.career.institution.parent_name}
    column(:modality) { |record| record.regularcourse.modality.name }
    column(:semester) { |record| record.regularcourse.semester }
    column(:credits) { |record| record.regularcourse.credits }

    column(:hoursxweek) { |record| record.hoursxweek }
    column(:period) { |record| record.period.title}
    column(:roleinregularcourse) { |record| record.roleinregularcourse.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :period, :label => 'Periodo'
  filter :find_by_year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :degree_id, :collection => proc { Degree.universitary }, :label => 'Grado', :as => :select
  filter :user, :label => 'Académico'
  filter :roleinregularcourse, :label => 'Rol'
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select

  csv do
    column(:title) { |record| record.regularcourse.title }
    column(:degree) { |record| record.regularcourse.academicprogram.career.degree.name }
    column(:career) { |record| record.regularcourse.academicprogram.career.name }
    column(:academicprogram_type) { |record| record.regularcourse.academicprogram.academicprogramtype.name }
    column(:faculty) { |record| record.regularcourse.academicprogram.career.institution.name}
    column(:institution) { |record| record.regularcourse.academicprogram.career.institution.parent_name}
    column(:modality) { |record| record.regularcourse.modality.name }
    column(:semester) { |record| record.regularcourse.semester }
    column(:credits) { |record| record.regularcourse.credits }

    column(:hoursxweek) { |record| record.hoursxweek }
    column(:period) { |record| record.period.title}
    column(:roleinregularcourse) { |record| record.roleinregularcourse.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

end
