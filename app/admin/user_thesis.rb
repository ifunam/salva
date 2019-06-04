# encoding: utf-8
ActiveAdmin.register UserThesis do
  #menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Docencia', :label => 'Tesis'

  index :title => 'Tesis' do
    column(:id) { |record| record.thesis.id }
    column(:title) { |record| record.thesis.title }
    column(:authors) { |record| record.thesis.authors }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column :roleinthesis
    column(:adscription) { |record| record.thesis.start_date.nil? ? record.user.adscription_name(record.user.id,Time.now.year) : record.user.adscription_name(record.user.id,record.thesis.start_date.year) }
    column(:degree) { |record| record.thesis.degree.nil? ? nil : record.thesis.degree.name }
    column(:career) { |record| record.thesis.career.nil? ? nil : record.thesis.career.name }
    column(:faculty) { |record| record.thesis.institution.nil? ? nil : record.thesis.institution.name }
    column(:university) { |record| record.thesis.university.nil? ? nil : record.thesis.university.name }
    column(:thesisstatus) { |record| record.thesis.thesisstatus.name}
    column(:thesismodality) { |record| record.thesis.thesismodality.name}
    column(:start_date) { |record| record.thesis.start_date}
    column(:end_date) { |record| record.thesis.end_date}
    column(:is_verified) { |record| record.thesis.is_verified? ? 'Sí' : 'No' }
  end

  filter :user, :label => 'Académico'
  filter :roleinthesis, :label => 'Rol'
  filter :degree_id, :collection => proc { Degree.universitary }, :label => 'Grado', :as => :select
  filter :thesisstatus_id, :collection => proc { Thesisstatus.all }, :label => 'Status', :as => :select
  filter :thesismodality_id, :collection => proc { Thesismodality.all }, :label => 'Modalidad', :as => :select
  filter :thesis, :collection => proc { Thesis.all }, :label => 'Título'
  filter :authors_cont, :as => :string, :label => 'Autor(es)'
  filter :start_date, :as => :string, :input_html => { :size => 12, :class => 'datepicker hasDatePicker' }, :label => 'Desde'
  filter :end_date, :as => :string, :input_html => { :size => 12, :class => 'datepicker hasDatePicker' }, :label => 'Hasta'
  filter :is_verified, :as => :boolean, :label => 'Verificadas'

  csv do
    column(:id) { |record| record.thesis.id }
    column(:title) { |record| record.thesis.title }
    column(:authors) { |record| record.thesis.authors }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:roleinthesis) { |record| record.roleinthesis.name }
    column(:adscription) { |record| record.thesis.start_date.nil? ? record.user.adscription_name(record.user.id,Time.now.year) : record.user.adscription_name(record.user.id,record.thesis.start_date.year) }
    column(:degree) { |record| record.thesis.degree.nil? ? nil : record.thesis.degree.name }
    column(:career) { |record| record.thesis.career.nil? ? nil : record.thesis.career.name }
    column(:faculty) { |record| record.thesis.institution.nil? ? nil : record.thesis.institution.name }
    column(:university) { |record| record.thesis.university.nil? ? nil : record.thesis.university.name }
    column(:thesisstatus) { |record| record.thesis.thesisstatus.name}
    column(:thesismodality) { |record| record.thesis.thesismodality.name}
    column(:start_date) { |record| record.thesis.start_date}
    column(:end_date) { |record| record.thesis.end_date}
    column(:is_verified) { |record| record.thesis.is_verified? ? 'Sí' : 'No' }
  end
end
