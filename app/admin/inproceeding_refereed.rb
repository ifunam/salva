# encoding: utf-8
ActiveAdmin.register UserInproceeding, :as => 'InproceedingRefereed'  do
  menu :parent => 'Publicaciones', :label => 'Artículos en memorias arbitradas'

  controller do
    def scoped_collection
      UserInproceeding.refereed
    end
  end

  index :title => 'Artículos en memorias arbitradas' do
    column(:id) { |record| record.inproceeding.id }

    column(:inproceeding_authors) { |record| record.inproceeding.authors }
    column(:inproceeding_title) { |record| record.inproceeding.title }
    column(:inproceeding_pages) { |record| record.inproceeding.pages }

    column(:proceeding_title) { |record| record.inproceeding.proceeding.title }
    column(:proceeding_year) { |record| record.inproceeding.proceeding.year}
    column(:proceeding_volume) { |record| record.inproceeding.proceeding.volume}
    column(:proceeding_publisher) { |record| record.inproceeding.proceeding.publisher_name}

    column(:conference_name) { |record| record.inproceeding.proceeding.conference.name }
    column(:conference_year) { |record| record.inproceeding.proceeding.conference.year }
    column(:conference_month) { |record| record.inproceeding.proceeding.conference.month }
    column(:conference_country) { |record| record.inproceeding.proceeding.conference.country.name }
    column(:conference_scope) { |record| record.inproceeding.proceeding.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.inproceeding.proceeding.conference.institution_names }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :user, :label => 'Académico'
  filter :conferencescope_id, :collection => proc { Conferencescope.all }, :label => 'Ámbito', :as => :select

  csv do
    column(:inproceeding_authors) { |record| record.inproceeding.authors }
    column(:inproceeding_title) { |record| record.inproceeding.title }
    column(:inproceeding_pages) { |record| record.inproceeding.pages }

    column(:proceeding_title) { |record| record.inproceeding.proceeding.title }
    column(:proceeding_year) { |record| record.inproceeding.proceeding.year}
    column(:proceeding_volume) { |record| record.inproceeding.proceeding.volume}
    column(:proceeding_publisher) { |record| record.inproceeding.proceeding.publisher_name}

    column(:conference_name) { |record| record.inproceeding.proceeding.conference.name }
    column(:conference_year) { |record| record.inproceeding.proceeding.conference.year }
    column(:conference_month) { |record| record.inproceeding.proceeding.conference.month }
    column(:conference_country) { |record| record.inproceeding.proceeding.conference.country.name }
    column(:conference_scope) { |record| record.inproceeding.proceeding.conference.conferencescope_name }
    column(:conference_institutions) { |record| record.inproceeding.proceeding.conference.institution_names }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
