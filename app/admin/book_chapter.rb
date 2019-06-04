# encoding: utf-8
ActiveAdmin.register ChapterinbookRoleinchapter, :as => 'BookChapter'  do
  menu :parent => 'Publicaciones', :label => 'Capítulos en libros'

  index :title => 'Capítulos en libros' do
    column(:id) { |record| record.chapterinbook.id }
    column(:chapter_title) { |record| record.chapterinbook.title }
    column(:chapter_type) { |record| record.chapterinbook.bookchaptertype.name }
    column(:chapter_pages) { |record| record.chapterinbook.pages }
    column(:book_title) { |record| record.chapterinbook.bookedition.book.title }
    column(:authors) { |record| record.chapterinbook.bookedition.book.authors }
    column(:volume) { |record| record.chapterinbook.bookedition.book.volume }
    column(:language)  { |record| record.chapterinbook.bookedition.book_language }
    column(:country)  { |record| record.chapterinbook.bookedition.book_country }
    column(:booktype)  { |record| record.chapterinbook.bookedition.book.booktype.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.chapterinbook.bookedition.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:roleinchapter) { |record| record.roleinchapter.name }
    column(:edition) { |record| record.chapterinbook.bookedition.edition }
    column(:isbn) { |record| record.chapterinbook.bookedition.isbn }
    column(:mediatype) { |record| record.chapterinbook.bookedition.mediatype_name }
    column(:editionstatus) { |record| record.chapterinbook.bookedition.editionstatus_name }
    column(:publishers) { |record| record.chapterinbook.bookedition.publishers_to_s }
    column(:year) { |record| record.chapterinbook.bookedition.year}
    column(:month) { |record| record.chapterinbook.bookedition.month }
    column(:pages) { |record| record.chapterinbook.bookedition.pages }
    column(:other) { |record| record.chapterinbook.bookedition.other }

    column "Url", :sortable => false do |record|
      unless record.chapterinbook.bookedition.book.booklink.to_s.empty?
        link_to 'Abrir enlace', record.chapterinbook.bookedition.book.booklink, :target => "_blank"
      end
    end
  end

  filter :find_by_year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :label => 'Año', :as => :select
  filter :user, :label => 'Académico'
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :roleinchapter

  csv do
    column(:chapter_title) { |record| record.chapterinbook.title }
    column(:chapter_type) { |record| record.chapterinbook.bookchaptertype.name }
    column(:chapter_pages) { |record| record.chapterinbook.pages }
    column(:book_title) { |record| record.chapterinbook.bookedition.book.title }
    column(:authors) { |record| record.chapterinbook.bookedition.book.authors }
    column(:volume) { |record| record.chapterinbook.bookedition.book.volume }
    column(:language)  { |record| record.chapterinbook.bookedition.book_language }
    column(:country)  { |record| record.chapterinbook.bookedition.book_country }
    column(:booktype)  { |record| record.chapterinbook.bookedition.book.booktype.name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.chapterinbook.bookedition.year }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:roleinchapter) { |record| record.roleinchapter.name }
    column(:edition) { |record| record.chapterinbook.bookedition.edition }
    column(:isbn) { |record| record.chapterinbook.bookedition.isbn }
    column(:mediatype) { |record| record.chapterinbook.bookedition.mediatype_name }
    column(:editionstatus) { |record| record.chapterinbook.bookedition.editionstatus_name }
    column(:publishers) { |record| record.chapterinbook.bookedition.publishers_to_s }
    column(:year) { |record| record.chapterinbook.bookedition.year}
    column(:month) { |record| record.chapterinbook.bookedition.month }
    column(:pages) { |record| record.chapterinbook.bookedition.pages }
    column(:other) { |record| record.chapterinbook.bookedition.other }
  end
end
