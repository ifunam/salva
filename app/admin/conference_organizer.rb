# encoding: utf-8
ActiveAdmin.register Userconference, :as => 'ConferenceOrganizer'  do
  menu :parent => 'Congresos', :label => 'Comités de congresos'

  controller do
    def scoped_collection
      Userconference.organizer
    end
  end

  index :title => 'Comités de congresos' do
    column(:id) { |record| record.conference.id }

    column(:conference_name) { |record| record.conference.name }
    column(:conference_location) { |record| record.conference.location }
    column(:conference_year) { |record| record.conference.year }
    column(:conference_month) { |record| record.conference.month }
    column(:conference_country) { |record| record.conference.country_name }
    column(:conference_type) { |record| record.conference.conferencetype_name }
    column(:conference_scope) { |record| record.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.conference.institution_names }

    column(:roleinconference) { |record| record.roleinconference.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.conference.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :conference, :label => 'Congreso'
  filter :roleinconference, :collection => proc { Roleinconference.organizers }, :as => :select
  filter :year_eq, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :conferencescope_id, :collection => proc { Conferencescope.all }, :label => 'Ámbito', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :user, :label => 'Académico'

  csv do
    column(:conference_name) { |record| record.conference.name }
    column(:conference_location) { |record| record.conference.location }
    column(:conference_year) { |record| record.conference.year }
    column(:conference_month) { |record| record.conference.month }
    column(:conference_country) { |record| record.conference.country_name }
    column(:conference_type) { |record| record.conference.conferencetype_name }
    column(:conference_scope) { |record| record.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.conference.institution_names }

    column(:roleinconference) { |record| record.roleinconference.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.conference.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
