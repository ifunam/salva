# encoding: utf-8
ActiveAdmin.register UserArticle, :as => "PublishedArticle"  do
  menu :parent => 'Publicaciones', :label => 'Artículos publicados'

  controller do
    def scoped_collection
      UserArticle.published
    end
  end

  index :title => 'Artículos publicados' do
    column(:id) { |record| record.article.id }
    column(:title) { |record| record.article.title }
    column(:authors) { |record| record.article.authors }
    column(:journal)  { |record| record.article.journal.name }
    column(:country)  { |record| record.article.journal.country_name }
    column(:publisher) { |record| record.article.journal.publisher_name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.article.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:pages) { |record| record.article.pages }
    column(:year) { |record| record.article.year}
    column(:month) { |record| record.article.month }
    column(:vol) { |record| record.article.vol }
    column(:num) { |record| record.article.num }
    column(:pacsnum) { |record| record.article.pacsnum }
    column(:other) { |record| record.article.other }
    column "Url", :sortable => false do |record|
      unless record.article.url.to_s.empty?
       link_to 'Abrir enlace', record.article.url, :target => "_blank"
      end
    end
    column "File", :sortable => false do |record|
      if !record.article.document.nil? and !record.article.document.url.nil?
        link_to 'Descargar', record.article.document.url, :target => "_blank"
      end
    end
    column(:articlestatus) { |record| record.article.articlestatus.name }
    column(:is_verified) { |record| record.article.is_verified? ? 'Sí' : 'No' }
  end

  filter :year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :journal_id, :collection => proc { Journal.all }, :label => 'Journal', :as => :select
  filter :user, :label => 'Académico'
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :is_verified, :label => 'Verificados', :as => :boolean

  csv do
    column(:title) { |record| record.article.title }
    column(:authors) { |record| record.article.authors }
    column(:journal)  { |record| record.article.journal.name }
    column(:country)  { |record| record.article.journal.country_name }
    column(:publisher) { |record| record.article.journal.publisher_name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.article.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:pages) { |record| record.article.pages }
    column(:year) { |record| record.article.year}
    column(:month) { |record| record.article.month }
    column(:vol) { |record| record.article.vol }
    column(:num) { |record| record.article.num }
    column(:pacsnum) { |record| record.article.pacsnum }
    column(:other) { |record| record.article.other }
    column(:articlestatus) { |record| record.article.articlestatus.name }
    column(:is_verified) { |record| record.article.is_verified? ? 'Sí' : 'No' }
  end
end
