# encoding: utf-8
ActiveAdmin.register Conferencetalk, :as => 'ConferenceTalk'  do
  menu :parent => 'Congresos', :label => 'Trabajos presentados en congresos sin repetidos'

  index :title => 'Trabajos presentados en congresos sin repetidos' do
    column(:id) { |record| record.id }

    column(:conferencetalk_authors) { |record| record.authors }
    column(:conferencetalk_title) { |record| record.title }
    column(:conferencetalk_talktype) { |record| record.talktype.name }

    column(:conference_name) { |record| record.conference.name }
    column(:conference_location) { |record| record.conference.location }
    column(:conference_talkacceptance) { |record| record.talkacceptance.name }
    column(:conference_year) { |record| record.conference.year }
    column(:conference_month) { |record| record.conference.month }
    column(:conference_country) { |record| record.conference.country_name }
    column(:conference_type) { |record| record.conference.conferencetype_name }
    column(:conference_scope) { |record| record.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.conference.institution_names }

    column(:registered_by) { |record| record.registered_by.fullname_or_email }
    column(:adscription) { |record| record.registered_by.adscription_name record.registered_by.id,record.conference.year }
  end

  filter :year_eq, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :conferencescope_id, :collection => proc { Conferencescope.all }, :label => 'Ámbito', :as => :select

  csv do
    column(:conferencetalk_authors) { |record| record.authors }
    column(:conferencetalk_title) { |record| record.title }
    column(:conferencetalk_talktype) { |record| record.talktype.name }

    column(:conference_name) { |record| record.conference.name }
    column(:conference_location) { |record| record.conference.location }
    column(:conference_talkacceptance) { |record| record.talkacceptance.name }
    column(:conference_year) { |record| record.conference.year }
    column(:conference_month) { |record| record.conference.month }
    column(:conference_country) { |record| record.conference.country_name }
    column(:conference_type) { |record| record.conference.conferencetype_name }
    column(:conference_scope) { |record| record.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.conference.institution_names }

    column(:registered_by) { |record| record.registered_by.fullname_or_email }
    column(:adscription) { |record| record.registered_by.adscription_name record.registered_by.id,record.conference.year }

  end
end
