# encoding: utf-8
ActiveAdmin.register UserRefereedJournal, :as => 'RefereedJournal'  do
  menu :parent => 'Colaboración en publicaciones', :label => 'Arbitraje de revistas'

  index :title => 'Arbitraje de Revistas' do
    column(:id) { |record| record.id }

    column(:journal_name) { |record| record.journal_name }
    column(:journal_country) { |record| record.journal_country }
    column(:refereed_criterium) { |record| record.refereed_criterium_name }
    column(:year) { |record| record.year }
    column(:month) { |record| record.month }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :year
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :user, :label => 'Académico'
  filter :refereed_criterium
  filter :journal

  csv do
    column(:journal_name) { |record| record.journal_name }
    column(:journal_country) { |record| record.journal_country }
    column(:refereed_criterium) { |record| record.refereed_criterium_name }
    column(:year) { |record| record.year }
    column(:month) { |record| record.month }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
