# encoding: utf-8
ActiveAdmin.register UserConferencetalk, :as => 'ConferenceTalk'  do
  menu :parent => 'Reportes', :label => 'Trabajos presentados en congresos'

  index :title => 'Trabajos presentados en congresos' do
    column(:id) { |record| record.conferencetalk.id }

    column(:conferencetalk_authors) { |record| record.conferencetalk.authors }
    column(:conferencetalk_title) { |record| record.conferencetalk.title }
    column(:conferencetalk_talktype) { |record| record.conferencetalk.talktype.name }

    column(:conference_name) { |record| record.conferencetalk.conference.name }
    column(:conference_location) { |record| record.conferencetalk.conference.location }
    column(:conference_talkacceptance) { |record| record.conferencetalk.talkacceptance.name }
    column(:conference_year) { |record| record.conferencetalk.conference.year }
    column(:conference_month) { |record| record.conferencetalk.conference.month }
    column(:conference_country) { |record| record.conferencetalk.conference.country_name }
    column(:conference_type) { |record| record.conferencetalk.conference.conferencetype_name }
    column(:conference_scope) { |record| record.conferencetalk.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.conferencetalk.conference.institution_names }

    column(:roleinconference_talk) { |record| record.roleinconferencetalk.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :year_eq, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :conferencescope_id, :collection => proc { Conferencescope.all }, :label => 'Ámbito', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :user, :label => 'Académico'

  csv do
    column(:conferencetalk_authors) { |record| record.conferencetalk.authors }
    column(:conferencetalk_title) { |record| record.conferencetalk.title }
    column(:conferencetalk_talktype) { |record| record.conferencetalk.talktype.name }

    column(:conference_name) { |record| record.conferencetalk.conference.name }
    column(:conference_location) { |record| record.conferencetalk.conference.location }
    column(:conference_talkacceptance) { |record| record.conferencetalk.talkacceptance.name }
    column(:conference_year) { |record| record.conferencetalk.conference.year }
    column(:conference_month) { |record| record.conferencetalk.conference.month }
    column(:conference_country) { |record| record.conferencetalk.conference.country_name }
    column(:conference_type) { |record| record.conferencetalk.conference.conferencetype_name }
    column(:conference_scope) { |record| record.conferencetalk.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.conferencetalk.conference.institution_names }

    column(:roleinconference_talk) { |record| record.roleinconferencetalk.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
