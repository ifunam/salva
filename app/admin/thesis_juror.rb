# encoding: utf-8
ActiveAdmin.register ThesisJuror do
  menu :parent => 'Docencia'

  index do
    column(:id) { |record| record.thesis.id }
    column(:title) { |record| record.thesis.title }
    column(:authors) { |record| record.thesis.authors }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column :roleinjury
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.thesis.end_date.year }
    column(:degree) { |record| record.thesis.degree.nil? ? nil : record.thesis.degree.name }
    column(:career) { |record| record.thesis.career.nil? ? nil : record.thesis.career.name }
    column(:faculty) { |record| record.thesis.institution.nil? ? nil : record.thesis.institution.name }
    column(:university) { |record| record.thesis.university.nil? ? nil : record.thesis.university.name }
    column(:thesismodality) { |record| record.thesis.thesismodality.name}
    column(:end_date) { |record| record.thesis.end_date}
  end

  filter :user, :label => 'Académico'
  filter :roleinjury, :label => 'Rol'
  filter :degree_id, :collection => proc { Degree.universitary }, :label => 'Grado', :as => :select
  filter :thesismodality_id, :collection => proc { Thesismodality.all }, :label => 'Modalidad', :as => :select
  filter :thesis, :collection => proc { Thesis.all }, :label => 'Título'
  filter :authors_cont, :as => :string, :label => 'Autor(es)'
  filter :since_date, :as => :string, :input_html => { :size => 12, :class => 'datepicker hasDatePicker' }, :label => 'Desde'
  filter :until_date, :as => :string, :input_html => { :size => 12, :class => 'datepicker hasDatePicker' }, :label => 'Hasta'

  csv do
    column(:title) { |record| record.thesis.title }
    column(:authors) { |record| record.thesis.authors }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:roleinjury) { |record| record.roleinjury.name }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.thesis.end_date.year }
    column(:degree) { |record| record.thesis.degree.nil? ? nil : record.thesis.degree.name }
    column(:career) { |record| record.thesis.career.nil? ? nil : record.thesis.career.name }
    column(:faculty) { |record| record.thesis.institution.nil? ? nil : record.thesis.institution.name }
    column(:university) { |record| record.thesis.university.nil? ? nil : record.thesis.university.name }
    column(:thesismodality) { |record| record.thesis.thesismodality.name}
    column(:end_date) { |record| record.thesis.end_date}
  end
end
