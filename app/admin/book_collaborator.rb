# encoding: utf-8
ActiveAdmin.register BookeditionRoleinbook, :as => 'BookCollaborator'  do
  menu :parent => 'Colaboración en publicaciones', :label => 'Colaboración libros'
  controller do
    def scoped_collection
      BookeditionRoleinbook.collaborators
    end
  end

  index :title => 'Colaboración en libros' do
    column(:id) { |record| record.bookedition.book.id }
    column(:title) { |record| record.bookedition.book.title }
    column(:authors) { |record| record.bookedition.book.authors }
    column(:volume) { |record| record.bookedition.book.volume }
    column(:language)  { |record| record.bookedition.book_language }
    column(:country)  { |record| record.bookedition.book_country }
    column(:booktype)  { |record| record.bookedition.book.booktype.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.bookedition.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:roleinbook) { |record| record.roleinbook.name }
    column(:edition) { |record| record.bookedition.edition }
    column(:isbn) { |record| record.bookedition.isbn }
    column(:mediatype) { |record| record.bookedition.mediatype_name }
    column(:editionstatus) { |record| record.bookedition.editionstatus_name }
    column(:publishers) { |record| record.bookedition.publishers_to_s }
    column(:year) { |record| record.bookedition.year}
    column(:month) { |record| record.bookedition.month }
    column(:pages) { |record| record.bookedition.pages }
    column(:other) { |record| record.bookedition.other }

    column "Url", :sortable => false do |record|
      unless record.bookedition.book.booklink.to_s.empty?
        link_to 'Abrir enlace', record.bookedition.book.booklink, :target => "_blank"
      end
    end
  end

  filter :find_by_year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :user, :label => 'Académico'
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :roleinbook_id, :collection => proc { Roleinbook.collaborators }, :label => 'Rol', :as => :select

  csv do
    column(:title) { |record| record.bookedition.book.title }
    column(:authors) { |record| record.bookedition.book.authors }
    column(:volume) { |record| record.bookedition.book.volume }
    column(:language)  { |record| record.bookedition.book_language }
    column(:country)  { |record| record.bookedition.book_country }
    column(:booktype)  { |record| record.bookedition.book.booktype.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.bookedition.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:roleinbook) { |record| record.roleinbook.name }
    column(:edition) { |record| record.bookedition.edition }
    column(:isbn) { |record| record.bookedition.isbn }
    column(:mediatype) { |record| record.bookedition.mediatype_name }
    column(:editionstatus) { |record| record.bookedition.editionstatus_name }
    column(:publishers) { |record| record.bookedition.publishers_to_s }
    column(:year) { |record| record.bookedition.year}
    column(:month) { |record| record.bookedition.month }
    column(:pages) { |record| record.bookedition.pages }
    column(:other) { |record| record.bookedition.other }
  end
end
