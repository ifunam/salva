class Bookedition < ActiveRecord::Base

  validates_presence_of :edition, :mediatype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :mediatype_id,  :greater_than => 0, :only_integer => true
  validates_numericality_of :editionstatus_id, :allow_nil => true, :greater_than => 0, :only_integer =>true

  belongs_to :book
  belongs_to :mediatype
  belongs_to :editionstatus

  named_scope :recent, :order => 'year DESC, month DESC',  :limit => 20
  named_scope :published, :conditions => 'editionstatus_id = 1'
  named_scope :inprogress, :conditions => 'editionstatus_id != 1'
  def as_text
    as_text_line([book.authors, book.title, label_for(edition, 'Edition'), label_for(isbn, 'ISBN'),
                  pages, year, month, label_for(book.country.name, 'País'), label_for(book.booktype.name, 'Tipo de libro'),
                  label_for(editionstatus.name, 'Estado')])
  end

end
