# encoding: utf-8
ActiveAdmin.register UserNewspaperarticle, :as => 'Newspaperarticle' do
  menu :parent => 'Divulgación', :label => 'Artículos periodísticos'

  index :title => 'Artículos periodísticos' do
    column :id

    column(:title) { |record| record.newspaperarticle.title }
    column(:authors) { |record| record.newspaperarticle.authors }
    column(:date) { |record| record.newspaperarticle.newsdate }
    column(:newspaper) { |record| record.newspaperarticle.newspaper.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :user, :label => 'Académico'
  filter :year_eq, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select

  csv do
    column(:title) { |record| record.newspaperarticle.title }
    column(:authors) { |record| record.newspaperarticle.authors }
    column(:date) { |record| record.newspaperarticle.newsdate }
    column(:newspaper) { |record| record.newspaperarticle.newspaper.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
