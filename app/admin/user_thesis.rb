# encoding: utf-8
ActiveAdmin.register UserThesis do
  #menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Reportes', :label => 'Tesis'

  index :title => 'Tesis' do
    column :id
    column(:title) { |record| record.thesis.title }
    column(:authors) { |record| record.thesis.authors }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column :roleinthesis
    column(:adscription) { |record| record.user.adscription_name }
    column(:degree) { |record| record.thesis.career.degree.name }
    column(:career) { |record| record.thesis.career.name }
    column(:faculty_and_institution) { |record| record.thesis.career.institution.name_and_parent_name}
    column(:thesisstatus) { |record| record.thesis.thesisstatus.name}
    column(:thesismodality) { |record| record.thesis.thesismodality.name}
    column(:start_date) { |record| record.thesis.start_date}
    column(:end_date) { |record| record.thesis.end_date}
    column(:is_verified) { |record| record.thesis.is_verified }
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
    column(:title) { |record| record.thesis.title }
    column(:authors) { |record| record.thesis.authors }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:roleinthesis) { |record| record.roleinthesis.name }
    column(:adscription) { |record| record.user.adscription_name }
    column(:degree) { |record| record.thesis.career.degree.name }
    column(:career) { |record| record.thesis.career.name }
    column(:faculty) { |record| record.thesis.career.institution.name}
    column(:institution) { |record| record.thesis.career.institution.parent_name}
    column(:thesisstatus) { |record| record.thesis.thesisstatus.name}
    column(:thesismodality) { |record| record.thesis.thesismodality.name}
    column(:start_date) { |record| record.thesis.start_date}
    column(:end_date) { |record| record.thesis.end_date}
  end
end
