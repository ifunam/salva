# encoding: utf-8
ActiveAdmin.register UserThesis do
  #menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Reportes'

  index do
    column :id
    column(:title) { |ut| ut.thesis.title }
    column(:authors) { |ut| ut.thesis.authors }
    column(:fullname) { |ut| ut.user.fullname_or_email }
    column(:worker_key) { |ut| ut.user.worker_key_or_login }
    column :roleinthesis
    column(:adscription) { |ut| ut.user.adscription_name }
    column(:degree) { |ut| ut.thesis.career.degree.name }
    column(:career) { |ut| ut.thesis.career.name }
    column(:faculty_and_institution) { |ut| ut.thesis.career.institution.name_and_parent_name}
    column(:thesisstatus) { |ut| ut.thesis.thesisstatus.name}
    column(:thesismodality) { |ut| ut.thesis.thesismodality.name}
    column(:start_date) { |ut| ut.thesis.start_date}
    column(:end_date) { |ut| ut.thesis.end_date}
    column(:is_verified) { |ut| ut.thesis.is_verified }
  end

  filter :user, :label => 'Académico'
  filter :roleinthesis, :label => 'Rol'
  filter :thesisstatus_id, :collection => proc { Thesisstatus.all }, :label => 'Status', :as => :select
  filter :thesismodality_id, :collection => proc { Thesismodality.all }, :label => 'Modalidad', :as => :select
  filter :thesis, :collection => proc { Thesis.all }, :label => 'Título'
  filter :authors_cont, :as => :string, :label => 'Autor(es)'
  filter :start_date, :as => :string, :input_html => { :size => 12, :class => 'datepicker hasDatePicker' }, :label => 'Mayor a fecha de inicio'
  filter :end_date, :as => :string, :input_html => { :size => 12, :class => 'datepicker hasDatePicker' }, :label => 'Menor a fecha de término'
  filter :is_verified, :as => :boolean, :label => 'Verificadas'

  csv do
    column(:title) { |ut| ut.thesis.title }
    column(:authors) { |ut| ut.thesis.authors }
    column(:fullname) { |ut| ut.user.fullname_or_email }
    column(:worker_key) { |ut| ut.user.worker_key_or_login }
    column(:roleinthesis) { |record| record.roleinthesis.name }
    column(:adscription) { |ut| ut.user.adscription_name }
    column(:degree) { |ut| ut.thesis.career.degree.name }
    column(:career) { |ut| ut.thesis.career.name }
    column(:faculty) { |ut| ut.thesis.career.institution.name}
    column(:institution) { |ut| ut.thesis.career.institution.parent_name}
    column(:thesisstatus) { |ut| ut.thesis.thesisstatus.name}
    column(:thesismodality) { |ut| ut.thesis.thesismodality.name}
    column(:start_date) { |ut| ut.thesis.start_date}
    column(:end_date) { |ut| ut.thesis.end_date}
  end
end
