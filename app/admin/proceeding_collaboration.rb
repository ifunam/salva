# encoding: utf-8
ActiveAdmin.register UserProceeding, :as => 'ProceedingCollaboration'  do
  menu :parent => 'Colaboración en publicaciones', :label => 'Colaboración en memorias'

  index :title => 'Colaboración en memorias' do
    column(:id) { |record| record.id }

    column(:proceeding_title) { |record| record.proceeding.title }
    column(:proceeding_year) { |record| record.proceeding.year}
    column(:proceeding_volume) { |record| record.proceeding.volume}
    column(:proceeding_publisher) { |record| record.proceeding.publisher_name}

    column(:conference_name) { |record| record.proceeding.conference.name }
    column(:conference_name) { |record| record.proceeding.conference.location }
    column(:conference_year) { |record| record.proceeding.conference.year }
    column(:conference_month) { |record| record.proceeding.conference.month }
    column(:conference_country) { |record| record.proceeding.conference.country.name }
    column(:conference_scope) { |record| record.proceeding.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.proceeding.conference.institution_names }

    column(:roleproceeding) { |record| record.roleproceeding.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user,record.proceeding.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :user, :label => 'Académico'
  filter :roleproceeding
  filter :conferencescope_id, :collection => proc { Conferencescope.all }, :label => 'Ámbito', :as => :select

  csv do
    column(:proceeding_title) { |record| record.proceeding.title }
    column(:proceeding_year) { |record| record.proceeding.year}
    column(:proceeding_volume) { |record| record.proceeding.volume}
    column(:proceeding_publisher) { |record| record.proceeding.publisher_name}

    column(:conference_name) { |record| record.proceeding.conference.name }
    column(:conference_name) { |record| record.proceeding.conference.location }
    column(:conference_year) { |record| record.proceeding.conference.year }
    column(:conference_month) { |record| record.proceeding.conference.month }
    column(:conference_country) { |record| record.proceeding.conference.country.name }
    column(:conference_scope) { |record| record.proceeding.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.proceeding.conference.institution_names }

    column(:roleproceeding) { |record| record.roleproceeding.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user,record.proceeding.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
