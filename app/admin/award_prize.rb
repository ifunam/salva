# encoding: utf-8
ActiveAdmin.register UserPrize, :as => 'AwardPrize' do
  menu :parent => 'Otros', :label => 'Premios y distinciones'

  index :title => 'Premios y distinciones' do
    column :id
    column(:award_type) { |record| record.prize.prizetype.name }
    column(:award_name) { |record| record.prize.name }
    column(:award_institution) { |record| record.prize.institution.name }
    column :year
    column :month

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :user, :label => 'Académico'
  filter :year
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select

  csv do
    column(:award_type) { |record| record.prize.prizetype.name }
    column(:award_name) { |record| record.prize.name }
    column(:award_institution) { |record| record.prize.institution.name }
    column :year
    column :month

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
